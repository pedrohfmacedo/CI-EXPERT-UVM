//Function: The test bench applies random values to 3-bit select lines and checks the
//dout. The waveform mux8x1_tb.vcd can be observed using waveform viewer.
//Test bench file: mux8x1_tb.v

// Interface 
interface mux8x1_if (input logic clk);
    logic rstn;
    logic en;
    logic [2:0] sel;
    logic [7:0] din;
    logic dout;   
endinterface

//Top
module mux8x1_tb;

logic clk = 0;
logic dout;
logic expected;
// Instance of the interface
mux8x1_if mux_if (.clk(clk));

// Counter Scoreboard
int pass_count = 0;
int fail_count = 0;

// clock generation
always #5 clk = ~clk; // toggle clock for every 5 ticks

// Instance DUT
mux8x1 dut (
    .clk(mux_if.clk),
    .rstn(mux_if.rstn),
    .en(mux_if.en),  // avtive high enable
    .din(mux_if.din), //data input
    .sel(mux_if.sel), // select lines
    .dout(mux_if.dout) // data output
);
// Reference model
function logic reference_model(logic en, logic [2:0] sel, logic [7:0] din, logic prev_out);
    if (en)
        return din[sel];
    else
        return prev_out;
endfunction

// Check function scores the results (Scoreboard)
function void check(logic dut_out, logic ref_out, logic en, logic [2:0] sel, logic [7:0] din);
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
    mux_if.rstn = 0;
    mux_if.en = 0;
    mux_if.sel = 0;
    mux_if.din = 0;
        
    repeat (2) @(posedge clk);
    mux_if.rstn = 1;
    mux_if.en = 1;
    expected = 0;

    // Check one cycle after reset release
    @(posedge clk); #1;
    expected = reference_model(mux_if.en, mux_if.sel, mux_if.din, expected);
    check(mux_if.dout, expected, mux_if.en, mux_if.sel, mux_if.din);

    // Loop for tests
    repeat (100) begin

        // Randomize inputs
        @(negedge clk);
        mux_if.sel = $urandom_range(0, 7);
        mux_if.din = $urandom_range(0, 255);
        //mux_if.din = 8'h0F;

        // Wait for the output to stabilize
        @(posedge clk); #1;

        // Get expected output from reference model
        expected = reference_model(mux_if.en, mux_if.sel, mux_if.din, expected);

        // Check DUT output against expected output
        check(mux_if.dout, expected, mux_if.en, mux_if.sel, mux_if.din);
    end

    mux_if.en = 0;
    repeat (100) begin
        // Randomize inputs
        mux_if.sel = $urandom_range(0, 7);
        //mux_if.din = $urandom_range(0, 255);
    
        // Wait for the output to stabilize
        @(posedge clk); #1;

        // Get expected output from reference model
        expected = reference_model(mux_if.en, mux_if.sel, mux_if.din, expected);

        // Check DUT output against expected output
        check(mux_if.dout, expected, mux_if.en, mux_if.sel, mux_if.din);
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
    $fsdbDumpfile("mux1x8.fsdb");
    $fsdbDumpvars();
end

endmodule
