//Function: The test bench applies random values to 3-bit select lines and checks the
//dout. The waveform mux8x1_tb.vcd can be observed using waveform viewer.
//Test bench file: mux8x1_tb.v

// Interface 
interface arbiter_if (input logic clk);
    logic reset_n;
    logic en;
    logic priority_sel; // input
    logic client1_req;  // input
    logic client2_req;  // input  
    logic o_grant1;     // output
    logic o_grant2;     // output
endinterface

//Top
module arbiter_tb;

logic clk = 0;
logic expected1;
logic expected2;

// Instance of the interface
arbiter_if ab_if (.clk(clk));

// Counter Scoreboard
int pass_count = 0;
int fail_count = 0;

// clock generation
always #5 clk = ~clk; // toggle clock for every 5 ticks

// Instance DUT
dut ( .clk(ab_if.clk),
      .reset_n(ab_if.reset_n),
      .en(ab_if.en),
      .priority_sel(ab_if.priority_sel),
      .client1_req(ab_if.client1_req),
      .client2_req(ab_if.client2_req),
      .o_grant1(ab_if.o_grant1),
      .o_grant2(ab_if.o_grant2)
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
    ab_if.rstn = 0;
        
    repeat (2) @(posedge clk);
    ab_if.rstn = 1;
    ab_if.en = 1;
    expected1 = 0;
    expected2 = 0;
    // Check one cycle after reset release
    @(posedge clk); #1;
    
    // Get expected output from reference model
    expected = reference_model();

    // Check DUT output against expected output
    check();

    ab_if.en = 0;
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

    ab_if.en = 0;
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
    $fsdbDumpfile("arbiter.fsdb");
    $fsdbDumpvars();
end

endmodule