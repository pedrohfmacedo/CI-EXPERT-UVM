// Interface 
interface robot_if (input logic clk);
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
    // in
   logic s0_unload_done;
   logic s1_unload_done;
   logic s2_unload_done;
   logic s3_unload_done;
endinterface

//Top
module robot_model_tb;

logic clk = 0;
logic exp_s0_unloadstart;
logic exp_s1_unloadstart;
logic exp_s2_unloadstart;
logic exp_s3_unloadstart;


// Instance of the interface
robot_if_if rb_if (.clk(clk));

// Counter Scoreboard
int pass_count = 0;
int fail_count = 0;

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

// Reference model
function logic reference_model();

endfunction

// Check function scores the results (Scoreboard)
function void check();
    if (dut_out === ref_out)
        pass_count++;
    else begin
        fail_count++;
        $display("[ERROR] time=%0t en=%b sel=%d din=%b | DUT=%b REF=%b",
                 $time, en, sel, din, dut_out, ref_out);
    end
endfunction

// Test sequence, stimulus generation

initial begin
 $display("========= Initial tests =========");

    // Initialize interface signals (Reset)
    _if.rstn = 0;
    _if.en = 0;

        
    repeat (2) @(posedge clk);
   _if.rstn = 1;
    _if.en = 1;
    expected = 0;

    // Check one cycle after reset release
    @(posedge clk); #1;
    
    // Get expected output from reference model
    expected = reference_model();

    // Check DUT output against expected output
    check();

    // Loop for tests
    repeat (100) begin

        // Randomize inputs
        @(negedge clk);


        // Wait for the output to stabilize
        @(posedge clk); #1;

        // Get expected output from reference model
        expected = reference_model();

        // Check DUT output against expected output
        check();
    end

    _if.en = 0;
    repeat (100) begin
        // Randomize inputs
        //mux_if.din = $urandom_range(0, 255);
    
        // Wait for the output to stabilize
        @(posedge clk); #1;

        // Get expected output from reference model
        expected = reference_model();

        // Check DUT output against expected output
        check();
    end

        // Summary
        $display("\n================ SUMMARY ================");
        $display("PASS: %d", pass_count);
        $display("FAIL: %d", fail_count);
        $display("==========================================\n");
        $finish;
end

// FSDB dump for waveform viewing
initial begin
    $fsdbDumpfile("robot_model.fsdb");
    $fsdbDumpvars();
end

endmodule