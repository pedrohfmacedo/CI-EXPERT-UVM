//Function: The test bench applies random values to 3-bit select lines and checks the
//dout. The waveform mux8x1_tb.vcd can be observed using waveform viewer.
//Test bench file: mux8x1_tb.v

// Interface 
interface _if (input logic clk);
    logic rstn;
    logic en;
    //...
endinterface

//Top
module _tb;

logic clk = 0;
logic expected;

// Instance of the interface
_if _if (.clk(clk));

// Counter Scoreboard
int pass_count = 0;
int fail_count = 0;

// clock generation
always #5 clk = ~clk; // toggle clock for every 5 ticks

// Instance DUT
dut (

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
    $fsdbDumpfile(".fsdb");
    $fsdbDumpvars();
end

endmodule