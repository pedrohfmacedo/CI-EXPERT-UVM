//Top
module decoder2x4_tb;

// Interface
logic clk = 0;
logic rstn;
logic en;
logic [1:0] din;
logic [3:0] dout;

// Counter Scoreboard
logic [3:0] expected;
int pass_count = 0;
int fail_count = 0;

// clock generation
always #5 clk = ~clk; // toggle clock for every 5 ticks

// Instance DUT
decoder2x4 dut (
    .clk(clk),
    .rstn(rstn),
    .en(en),
    .din(din),
    .dout(dout)
);

// Reference model
function logic [3:0] reference_model(logic en, logic [1:0] din, logic [3:0] prev_out);
    if (en) begin
        return 4'b0001 << din;  // Desloca o bit 1 para a posição indicada por din (0-3)
    end else begin
        return prev_out; // Mantém a saída anterior se en for 0
    end
endfunction

// Check function scores the results (Scoreboard)
function void check(logic [3:0] dut_out, logic [3:0] ref_out, logic en, logic [1:0] din);
    if (dut_out === ref_out)
        pass_count++;
    else begin
        fail_count++;
        $display("[ERROR] time=%0t en=%b din=%d | DUT=%b REF=%b",
                 $time, en, din, dut_out, ref_out);
    end
endfunction

// Test sequence, stimulus generation

initial begin
 $display("========= Initial tests =========");

    // Initialize interface signals (Reset)
    rstn = 0;
    en = 0;

    // Check one cycle after reset release
    repeat (2) @(posedge clk);
    rstn = 1;
    expected = 0;
    din = 0;

    // Check one cycle after reset release
    @(posedge clk); #1;
    rstn = 1;

    // Get expected output from reference model
    expected = reference_model(en, din, expected);

    // Check DUT output against expected output
    check(dout, expected, en, din);

    en = 1;
    // Loop for tests
    repeat (100) begin

        // Randomize inputs
        @(negedge clk);
        din = $urandom_range(0, 4);

        // Wait for the output to stabilize
        @(posedge clk); #1;

        // Get expected output from reference model
        expected = reference_model(en, din, expected);

        // Check DUT output against expected output
        check(dout, expected, en, din);
    end

    en = 0;
    repeat (100) begin
        // Randomize inputs
        din = $urandom_range(0, 4);

        // Wait for the output to stabilize
        @(posedge clk); #1;

        // Get expected output from reference model
        expected = reference_model( en, din, expected);

        // Check DUT output against expected output
        check(dout, expected, en, din);
    end

    // Range da entrada fora do esperado
    en = 1;
    repeat (100) begin
        // Randomize inputs
        din = $urandom_range(5, 15);    
        // Wait for the output to stabilize
        @(posedge clk); #1;
        // Get expected output from reference model
        expected = reference_model(en, din, expected);
        // Check DUT output against expected output
        check(dout, expected, en, din);
    end

    en = 0;
    repeat (100) begin
        // Randomize inputs
        din = $urandom_range(5, 15);    
        // Wait for the output to stabilize
        @(posedge clk); #1;
        // Get expected output from reference model
        expected = reference_model(en, din, expected);
        // Check DUT output against expected output
        check(dout, expected, en, din);
    end
        // Summary
        $display("\n===================== SUMMARY =====================");
        $display("PASS: %d", pass_count);
        $display("FAIL: %d", fail_count);
        $display("===================================================\n");
        $finish;

end

// FSDB dump for waveform viewing
initial begin
    $fsdbDumpfile("decoder2x4.fsdb");
    $fsdbDumpvars();
end

endmodule