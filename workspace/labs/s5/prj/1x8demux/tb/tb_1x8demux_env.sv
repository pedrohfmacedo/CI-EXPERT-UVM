//Function: The test bench applies random values to 3-bit select lines and checks the
//dout. The waveform demux_tb.vcd can be observed using waveform viewer.
//Test bench file: demux3x8_tb.v

// Interface 
interface demux1x8_if (input logic clk);
    logic rstn;
    logic en;
    logic [2:0] sel;
    logic din;
    logic [7:0] dout;   
endinterface

// Top 
module demux1x8_tb;

logic clk = 0;
logic [7:0] expected;

// Instance of the interface
demux1x8_if demux_if (.clk(clk));

// Counter Scoreboard
int pass_count = 0;
int fail_count = 0;

// Clock generation
always #5 clk = ~clk; 

// Instance DUT
demux1x8 dut (
    .clk(demux_if.clk),
    .rstn(demux_if.rstn),
    .en(demux_if.en),
    .sel(demux_if.sel),
    .din(demux_if.din),
    .dout(demux_if.dout)
);

// Reference model
function logic [7:0] reference_model(logic en, logic [2:0] sel, logic din);
    if (en) begin
        case (sel)
            3'b000: return {7'b0, din};
            3'b001: return {6'b0, din, 1'b0};
            3'b010: return {5'b0, din, 2'b0};
            3'b011: return {4'b0, din, 3'b0};
            3'b100: return {3'b0, din, 4'b0};
            3'b101: return {2'b0, din, 5'b0};
            3'b110: return {1'b0, din, 6'b0};
            3'b111: return {din, 7'b0};
            default: return 8'b0;
        endcase
    end else begin
        return 8'b0;
    end   
endfunction

// Check function, scores the results (Scoreboard)
function void check(logic [7:0] dut_out, logic [7:0] ref_out, logic en, logic [2:0] sel, logic din);
    if (dut_out === ref_out)
        pass_count++;
    else begin
        fail_count++;
        $display("[ERROR] time=%0t en=%b sel=%3b din=%b | DUT=%8b REF=%8b",
                 $time, en, sel, din, dut_out, ref_out);
    end
endfunction

// Test sequence, stimulus generation

initial begin
    $display("========= Initial tests =========");

    // Initialize interface signals (Reset)
    demux_if.rstn = 0;
    demux_if.en = 0;
    demux_if.sel = 0;
    demux_if.din = 0;
        
    repeat (2) @(posedge clk);
    demux_if.rstn = 1;

    //Loop for tests
    repeat (100) begin
        // Randomize inputs
        demux_if.en = $urandom_range(0, 1);
        demux_if.sel = $urandom_range(0, 7);
        demux_if.din = $urandom_range(0, 1);

        // Wait for the output to stabilize
        @(posedge clk);

        // Get expected output from reference model
        expected = reference_model(demux_if.en, demux_if.sel, demux_if.din);

        // Check DUT output against expected output
        check(demux_if.dout, expected, demux_if.en, demux_if.sel, demux_if.din);
    end

        // Summary
        $display("\n======== SUMMARY ========");
        $display("PASS: %d", pass_count);
        $display("FAIL: %d", fail_count);
        $display("========================\n");

        $finish;
end

initial begin
    $dumpfile("demux1x8_tb.vcd");
    $dumpvars(0, demux1x8_tb);
end

endmodule