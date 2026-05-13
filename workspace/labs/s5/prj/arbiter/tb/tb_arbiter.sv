// ============================================================
// Interface
// ============================================================

interface arbiter_if (input logic clk);

    logic reset_n;
    logic priority_sel;
    logic client1_req;
    logic client2_req;

    logic o_grant1;
    logic o_grant2;

endinterface


// ============================================================
// TOP TESTBENCH
// ============================================================

module arbiter_tb;

logic clk = 0;

logic exp_grant1;
logic exp_grant2;

// ------------------------------------------------------------
// Reference model state variables
// ------------------------------------------------------------

reg [1:0] ref_curr_state;

reg ref_client1_req_d;
reg ref_client2_req_d;

// ------------------------------------------------------------
// Interface instance
// ------------------------------------------------------------

arbiter_if ab_if (.clk(clk));

// ------------------------------------------------------------
// Scoreboard counters
// ------------------------------------------------------------

int pass_count = 0;
int fail_count = 0;

// ------------------------------------------------------------
// Clock generation
// ------------------------------------------------------------

always #5 clk = ~clk;

// ------------------------------------------------------------
// DUT
// ------------------------------------------------------------

arbiter dut (
    .clk          (ab_if.clk),
    .reset_n      (ab_if.reset_n),
    .priority_sel (ab_if.priority_sel),
    .client1_req  (ab_if.client1_req),
    .client2_req  (ab_if.client2_req),
    .o_grant1     (ab_if.o_grant1),
    .o_grant2     (ab_if.o_grant2)
);

// ============================================================
// REFERENCE MODEL
// ============================================================

function void reference_model(
    input logic priority_sel,
    input logic client1_req,
    input logic client2_req,

    output logic exp_grant1,
    output logic exp_grant2
);

    parameter
        IDLE    = 2'd0,
        CLINET1 = 2'd1,
        CLINET2 = 2'd2;

    // --------------------------------------------------------
    // Delayed request logic
    // --------------------------------------------------------

    if (exp_grant1)
        ref_client1_req_d = 1'd0;
    else if (client1_req)
        ref_client1_req_d = 1'd1;

    if (exp_grant2)
        ref_client2_req_d = 1'd0;
    else if (client2_req)
        ref_client2_req_d = 1'd1;

    // --------------------------------------------------------
    // FSM
    // --------------------------------------------------------

    case (ref_curr_state)

        IDLE: begin

            if (priority_sel && ref_client1_req_d)
                ref_curr_state = CLINET1;

            else if (ref_client2_req_d)
                ref_curr_state = CLINET2;

            else
                ref_curr_state = IDLE;

        end

        CLINET1: begin

            if (ref_client2_req_d)
                ref_curr_state = CLINET2;
            else
                ref_curr_state = IDLE;

        end

        CLINET2: begin

            if (ref_client1_req_d)
                ref_curr_state = CLINET1;
            else
                ref_curr_state = IDLE;

        end

        default:
            ref_curr_state = IDLE;

    endcase

    // --------------------------------------------------------
    // Expected outputs
    // --------------------------------------------------------

    exp_grant1 = (ref_curr_state == CLINET1);
    exp_grant2 = (ref_curr_state == CLINET2);

endfunction

// ============================================================
// RESET REFERENCE MODEL
// ============================================================

function void reset_reference_model();

    ref_curr_state    = 2'd0;
    ref_client1_req_d = 1'd0;
    ref_client2_req_d = 1'd0;

endfunction

// ============================================================
// SCOREBOARD CHECKER
// ============================================================

function void check(

    logic o_grant1,
    logic o_grant2,

    logic exp_grant1,
    logic exp_grant2,

    logic priority_sel,
    logic client1_req,
    logic client2_req
);

    if ((o_grant1 === exp_grant1) &&
        (o_grant2 === exp_grant2)) begin

        pass_count++;

        $display(
        "[PASS] time=%0t | sel=%0b c1=%0b c2=%0b | DUT=(%0b,%0b) REF=(%0b,%0b)",
        $time,
        priority_sel,
        client1_req,
        client2_req,
        o_grant1,
        o_grant2,
        exp_grant1,
        exp_grant2
        );

    end

    else begin

        fail_count++;

        $display(
        "[FAIL] time=%0t | sel=%0b c1=%0b c2=%0b | DUT=(%0b,%0b) REF=(%0b,%0b)",
        $time,
        priority_sel,
        client1_req,
        client2_req,
        o_grant1,
        o_grant2,
        exp_grant1,
        exp_grant2
        );

    end

endfunction

// ============================================================
// TEST SEQUENCE
// ============================================================

initial begin

    $display("\n========================================");
    $display("         ARBITER TESTBENCH");
    $display("========================================");

    // --------------------------------------------------------
    // INITIALIZATION
    // --------------------------------------------------------

    ab_if.reset_n      = 0;
    ab_if.priority_sel = 0;
    ab_if.client1_req  = 0;
    ab_if.client2_req  = 0;

    exp_grant1 = 0;
    exp_grant2 = 0;

    reset_reference_model();

    repeat(2) @(posedge clk);

    ab_if.reset_n = 1;

    // ========================================================
    // TEST 1 : ONLY CLIENT1 REQUEST
    // ========================================================

    $display("\n========== TEST 1 : CLIENT1 ==========");

    ab_if.priority_sel = 0;
    ab_if.client1_req  = 1;
    ab_if.client2_req  = 0;

    @(posedge clk); #1;

    reference_model(
        ab_if.priority_sel,
        ab_if.client1_req,
        ab_if.client2_req,
        exp_grant1,
        exp_grant2
    );

    check(
        ab_if.o_grant1,
        ab_if.o_grant2,
        exp_grant1,
        exp_grant2,
        ab_if.priority_sel,
        ab_if.client1_req,
        ab_if.client2_req
    );

    // ========================================================
    // TEST 2 : ONLY CLIENT2 REQUEST
    // ========================================================

    $display("\n========== TEST 2 : CLIENT2 ==========");

    ab_if.priority_sel = 0;
    ab_if.client1_req  = 0;
    ab_if.client2_req  = 1;

    @(posedge clk); #1;

    reference_model(
        ab_if.priority_sel,
        ab_if.client1_req,
        ab_if.client2_req,
        exp_grant1,
        exp_grant2
    );

    check(
        ab_if.o_grant1,
        ab_if.o_grant2,
        exp_grant1,
        exp_grant2,
        ab_if.priority_sel,
        ab_if.client1_req,
        ab_if.client2_req
    );

    // ========================================================
    // TEST 3 : SIMULTANEOUS REQUESTS
    // ========================================================

    $display("\n========== TEST 3 : SIMULTANEOUS ==========");

    ab_if.priority_sel = 1;
    ab_if.client1_req  = 1;
    ab_if.client2_req  = 1;

    @(posedge clk); #1;

    reference_model(
        ab_if.priority_sel,
        ab_if.client1_req,
        ab_if.client2_req,
        exp_grant1,
        exp_grant2
    );

    check(
        ab_if.o_grant1,
        ab_if.o_grant2,
        exp_grant1,
        exp_grant2,
        ab_if.priority_sel,
        ab_if.client1_req,
        ab_if.client2_req
    );

    // ========================================================
    // TEST 4 : ALTERNATING REQUESTS
    // ========================================================

    $display("\n========== TEST 4 : ALTERNATING ==========");

    repeat (6) begin

        ab_if.priority_sel = $urandom_range(0,1);
        ab_if.client1_req  = ~ab_if.client1_req;
        ab_if.client2_req  = ~ab_if.client2_req;

        @(posedge clk); #1;

        reference_model(
            ab_if.priority_sel,
            ab_if.client1_req,
            ab_if.client2_req,
            exp_grant1,
            exp_grant2
        );

        check(
            ab_if.o_grant1,
            ab_if.o_grant2,
            exp_grant1,
            exp_grant2,
            ab_if.priority_sel,
            ab_if.client1_req,
            ab_if.client2_req
        );

    end

    // ========================================================
    // TEST 5 : RESET DURING OPERATION
    // ========================================================

    $display("\n========== TEST 5 : RESET ==========");

    ab_if.priority_sel = 1;
    ab_if.client1_req  = 1;
    ab_if.client2_req  = 1;

    @(posedge clk);

    ab_if.reset_n = 0;

    reset_reference_model();

    @(posedge clk); #1;

    exp_grant1 = 0;
    exp_grant2 = 0;

    check(
        ab_if.o_grant1,
        ab_if.o_grant2,
        exp_grant1,
        exp_grant2,
        ab_if.priority_sel,
        ab_if.client1_req,
        ab_if.client2_req
    );

    ab_if.reset_n = 1;

    // ========================================================
    // RANDOM TESTS
    // ========================================================

    $display("\n========== RANDOM TESTS ==========");

    repeat (50) begin

        ab_if.priority_sel = $urandom_range(0,1);
        ab_if.client1_req  = $urandom_range(0,1);
        ab_if.client2_req  = $urandom_range(0,1);

        @(posedge clk); #1;

        reference_model(
            ab_if.priority_sel,
            ab_if.client1_req,
            ab_if.client2_req,
            exp_grant1,
            exp_grant2
        );

        check(
            ab_if.o_grant1,
            ab_if.o_grant2,
            exp_grant1,
            exp_grant2,
            ab_if.priority_sel,
            ab_if.client1_req,
            ab_if.client2_req
        );

    end

    // ========================================================
    // SUMMARY
    // ========================================================

    $display("\n========================================");
    $display("               SUMMARY");
    $display("========================================");

    $display("PASS COUNT = %0d", pass_count);
    $display("FAIL COUNT = %0d", fail_count);

    $display("========================================\n");

    #50;
    $finish;

end

// ============================================================
// FSDB DUMP
// ============================================================

initial begin

    $fsdbDumpfile("arbiter.fsdb");
    $fsdbDumpvars();

end

endmodule