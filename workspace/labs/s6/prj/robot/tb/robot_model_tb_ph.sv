// Interface 
interface robot_if (input logic clk);
    logic reset_n;

    // in
    logic s0_req;
    logic s1_req;
    logic s2_req;
    logic s3_req;

    // out
    logic s0_unloadstart;
    logic s1_unloadstart;
    logic s2_unloadstart;
    logic s3_unloadstart;
    logic load_start;

    // in
    logic s0_unload_done;
    logic s1_unload_done;
    logic s2_unload_done;
    logic s3_unload_done;
endinterface

//Top
module robot_model_tb;

logic clk = 0;
logic exp_s0_unloadstart = 0;
logic exp_s1_unloadstart = 0;
logic exp_s2_unloadstart = 0;
logic exp_s3_unloadstart = 0;
logic exp_load_start = 0;

// Instance of the interface
robot_if rb_if (.clk(clk));

// Counter Scoreboard
int pass_count = 0;
int fail_count = 0;
int miss_count = 0;
int mismatch_count = 0;

// clock generation
always #5 clk = ~clk;

// Instance DUT
robot_model dut (
    .clock          (rb_if.clk),
    .reset_n        (rb_if.reset_n),
    .s0_req         (rb_if.s0_req),
    .s1_req         (rb_if.s1_req),
    .s2_req         (rb_if.s2_req),
    .s3_req         (rb_if.s3_req),
    .s0_unloadstart (rb_if.s0_unloadstart),
    .s1_unloadstart (rb_if.s1_unloadstart),
    .s2_unloadstart (rb_if.s2_unloadstart),
    .s3_unloadstart (rb_if.s3_unloadstart),
    .s0_unload_done (rb_if.s0_unload_done),
    .s1_unload_done (rb_if.s1_unload_done),
    .s2_unload_done (rb_if.s2_unload_done),
    .s3_unload_done (rb_if.s3_unload_done),
    .load_start     (rb_if.load_start)
);

// Reference model states
typedef enum logic [1:0] {
    REF_M_WAIT_REQ = 2'd0,
    REF_M_S0_S1    = 2'd1,
    REF_M_S2_S3    = 2'd2
} ref_main_state_e;

typedef enum logic [1:0] {
    REF_L_IDLE       = 2'd0,
    REF_L_WRIST_HOR  = 2'd1,
    REF_L_LOAD_ITEM  = 2'd2,
    REF_L_WRIST_VERT = 2'd3
} ref_load_state_e;

typedef enum logic [2:0] {
    REF_U_IDLE         = 3'd0,
    REF_U_JOINTA_RIGHT = 3'd1,
    REF_U_JOINTC_DOWN  = 3'd2,
    REF_U_RELEASE_CLAW = 3'd3,
    REF_U_JOINTC_UP    = 3'd4,
    REF_U_JOINTA_LEFT  = 3'd5
} ref_unload_state_e;

ref_main_state_e   ref_main_state;
ref_load_state_e   ref_load_state;
ref_unload_state_e ref_unload_state;

int ref_station;

logic [4:0] ref_out;
logic [4:0] dut_out;

// Create Vectors
logic [3:0] req_vec;
logic [3:0] done_vec;
logic [3:0] unloadstart_vec;

// Check if only one request is active (one-hot)
function automatic logic onehot(logic [3:0] value);
    onehot = (value == 4'b0001) ||
             (value == 4'b0010) ||
             (value == 4'b0100) ||
             (value == 4'b1000);
endfunction

// Convert one-hot to station number (0,1,2,3) or -1 if not valid
function automatic int station_from_req(logic [3:0] value);
    case (value)
        4'b0001: station_from_req = 0;
        4'b0010: station_from_req = 1;
        4'b0100: station_from_req = 2;
        4'b1000: station_from_req = 3;
        default: station_from_req = -1;
    endcase
endfunction

// Check if the station needs joint C (Station 1 and Station 3)
function automatic bit station_needs_joint_c(int station);
    station_needs_joint_c = (station == 1) || (station == 3);
endfunction

// Check if the station does not need joint C (Station 0 and Station 2)
function automatic bit station_does_not_need_joint_c(int station);
    station_does_not_need_joint_c = (station == 0) || (station == 2);
endfunction

// Check if the station is done (unload_done is high)
function automatic bit station_done(int station, logic [3:0] value);
    station_done = ((station >= 0) && (station < 4)) ? value[station] : 1'b0;
endfunction

function automatic void reset_reference_model();
    ref_main_state   = REF_M_WAIT_REQ;
    ref_load_state   = REF_L_IDLE;
    ref_unload_state = REF_U_IDLE;
    ref_station      = -1;

    exp_load_start     = 1'b0;
    exp_s0_unloadstart = 1'b0;
    exp_s1_unloadstart = 1'b0;
    exp_s2_unloadstart = 1'b0;
    exp_s3_unloadstart = 1'b0;

    ref_out = 5'b00000;
    dut_out = 5'b00000;
endfunction

task automatic reset();
    rb_if.reset_n = 1'b0;

    rb_if.s0_req = 1'b0;
    rb_if.s1_req = 1'b0;
    rb_if.s2_req = 1'b0;
    rb_if.s3_req = 1'b0;

    rb_if.s0_unload_done = 1'b0;
    rb_if.s1_unload_done = 1'b0;
    rb_if.s2_unload_done = 1'b0;
    rb_if.s3_unload_done = 1'b0;

    reset_reference_model();

    repeat (2) @(posedge clk);

    rb_if.reset_n = 1'b1;

    @(posedge clk);
    #1;
endtask

function automatic logic [4:0] reference_model();
    logic [3:0] reqs;
    logic [3:0] dones;

    reqs = {
        rb_if.s3_req,
        rb_if.s2_req,
        rb_if.s1_req,
        rb_if.s0_req
    };

    dones = {
        rb_if.s3_unload_done,
        rb_if.s2_unload_done,
        rb_if.s1_unload_done,
        rb_if.s0_unload_done
    };

    req_vec = reqs;
    done_vec = dones;

    unloadstart_vec = {
        rb_if.s3_unloadstart,
        rb_if.s2_unloadstart,
        rb_if.s1_unloadstart,
        rb_if.s0_unloadstart
    };

    if (!rb_if.reset_n) begin
        reset_reference_model();
    end
    else begin
        case (ref_main_state)
            REF_M_WAIT_REQ: begin
                if (onehot(reqs) && (reqs[0] || reqs[1]))
                    ref_main_state = REF_M_S0_S1;
                else if (onehot(reqs) && (reqs[2] || reqs[3]))
                    ref_main_state = REF_M_S2_S3;
            end

            REF_M_S0_S1,
            REF_M_S2_S3: begin
                if (dones != 4'b0000)
                    ref_main_state = REF_M_WAIT_REQ;
            end

            default:
                ref_main_state = REF_M_WAIT_REQ;
        endcase

        case (ref_load_state)
            REF_L_IDLE: begin
                if ((ref_station < 0) && onehot(reqs)) begin
                    ref_station = station_from_req(reqs);
                    ref_load_state = REF_L_WRIST_HOR;
                end
            end

            REF_L_WRIST_HOR:
                ref_load_state = REF_L_LOAD_ITEM;

            REF_L_LOAD_ITEM:
                ref_load_state = REF_L_WRIST_VERT;

            REF_L_WRIST_VERT:
                ref_load_state = REF_L_IDLE;

            default:
                ref_load_state = REF_L_IDLE;
        endcase

        case (ref_unload_state)
            REF_U_IDLE: begin
                if (ref_load_state == REF_L_WRIST_VERT)
                    ref_unload_state = REF_U_JOINTA_RIGHT;
            end

            REF_U_JOINTA_RIGHT: begin
                if (station_needs_joint_c(ref_station))
                    ref_unload_state = REF_U_JOINTC_DOWN;
                else
                    ref_unload_state = REF_U_RELEASE_CLAW;
            end

            REF_U_JOINTC_DOWN:
                ref_unload_state = REF_U_RELEASE_CLAW;

            REF_U_RELEASE_CLAW: begin
                if (station_needs_joint_c(ref_station))
                    ref_unload_state = REF_U_JOINTC_UP;
                else if (station_done(ref_station, dones))
                    ref_unload_state = REF_U_JOINTA_LEFT;
            end

            REF_U_JOINTC_UP: begin
                if (station_done(ref_station, dones))
                    ref_unload_state = REF_U_JOINTA_LEFT;
            end

            REF_U_JOINTA_LEFT: begin
                ref_unload_state = REF_U_IDLE;
                ref_station = -1;
            end

            default:
                ref_unload_state = REF_U_IDLE;
        endcase

        exp_load_start     = (ref_load_state == REF_L_WRIST_HOR);
        exp_s0_unloadstart = 1'b0;
        exp_s1_unloadstart = 1'b0;
        exp_s2_unloadstart = 1'b0;
        exp_s3_unloadstart = 1'b0;

        if ((ref_station >= 0) &&
            ((ref_load_state == REF_L_WRIST_VERT) ||
             (ref_unload_state != REF_U_IDLE))) begin
            case (ref_station)
                0: exp_s0_unloadstart = 1'b1;
                1: exp_s1_unloadstart = 1'b1;
                2: exp_s2_unloadstart = 1'b1;
                3: exp_s3_unloadstart = 1'b1;
            endcase
        end

        ref_out = {
            exp_load_start,
            exp_s3_unloadstart,
            exp_s2_unloadstart,
            exp_s1_unloadstart,
            exp_s0_unloadstart
        };
    end

    dut_out = {
        rb_if.load_start,
        rb_if.s3_unloadstart,
        rb_if.s2_unloadstart,
        rb_if.s1_unloadstart,
        rb_if.s0_unloadstart
    };

    reference_model = ref_out;
endfunction

// Check function scores the results (Scoreboard)
function void check();
    if (dut_out === ref_out) begin
        miss_count++;
        $display("[MISS] time=%0t req{S0,S1,S2,S3}={%b,%b,%b,%b} | unloadstart{s0,s1,s2,s3}={%b,%b,%b,%b} | unload_done{s0,s1,s2,s3}={%b,%b,%b,%b} | load_start=%b | dut_out=%05b ref_out=%05b",
                 $time,
                 rb_if.s0_req, rb_if.s1_req, rb_if.s2_req, rb_if.s3_req,
                 rb_if.s0_unloadstart, rb_if.s1_unloadstart, rb_if.s2_unloadstart, rb_if.s3_unloadstart,
                 rb_if.s0_unload_done, rb_if.s1_unload_done, rb_if.s2_unload_done, rb_if.s3_unload_done,
                 rb_if.load_start,
                 dut_out,
                 ref_out);
    end
    else begin
        mismatch_count++;
        $display("[MISMATCH] time=%0t req{S0,S1,S2,S3}={%b,%b,%b,%b} | unloadstart{s0,s1,s2,s3}={%b,%b,%b,%b} | unload_done{s0,s1,s2,s3}={%b,%b,%b,%b} | load_start=%b | dut_out=%05b ref_out=%05b",
                 $time,
                 rb_if.s0_req, rb_if.s1_req, rb_if.s2_req, rb_if.s3_req,
                 rb_if.s0_unloadstart, rb_if.s1_unloadstart, rb_if.s2_unloadstart, rb_if.s3_unloadstart,
                 rb_if.s0_unload_done, rb_if.s1_unload_done, rb_if.s2_unload_done, rb_if.s3_unload_done,
                 rb_if.load_start,
                 dut_out,
                 ref_out);
    end
endfunction

// Test sequence, stimulus generation
initial begin
    $display("========= Initial tests =========");

    // Initialize interface signals (Reset)
    reset();

    // Test FIXED pattern: req = 4'b0001
    @(negedge clk);
    rb_if.s0_req = 1'b1;
    rb_if.s1_req = 1'b0;
    rb_if.s2_req = 1'b0;
    rb_if.s3_req = 1'b0;

    rb_if.s0_unload_done = 1'b0;
    rb_if.s1_unload_done = 1'b0;
    rb_if.s2_unload_done = 1'b0;
    rb_if.s3_unload_done = 1'b0;

    @(posedge clk);
    #1;

    ref_out = reference_model();
    check();

    // Summary
    $display("\n================ SUMMARY ================");
    $display("MISS: %d", miss_count);
    $display("MISMATCH: %d", mismatch_count);
    $display("==========================================\n");

    $finish;
end

// FSDB dump for waveform viewing
initial begin
    $fsdbDumpfile("robot_model.fsdb");
    $fsdbDumpvars();
end

endmodule