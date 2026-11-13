// Testbench for 16x16 multiplier
// The testbench drives operands and enable, then compares DUT output with a reference model.

// Interface 
interface multiplier_if (input logic clk);
    logic reset_n;
    logic en;
    logic [15:0] op_a;
    logic [15:0] op_b;
    logic [31:0] multi_out;
endinterface

//Top
module multiplier_tb;

logic clk = 0;
logic [31:0] expected;
logic [31:0] expected_next;

// Instance of the interface
multiplier_if multiplier_if (.clk(clk));

// Counter Scoreboard
int pass_count = 0;
int fail_count = 0;

// clock generation
always #5 clk = ~clk; // toggle clock for every 5 ticks

// Instance DUT
multiplier dut (
    .clk(multiplier_if.clk),
    .reset_n(multiplier_if.reset_n),
    .en(multiplier_if.en),
    .op_a(multiplier_if.op_a),
    .op_b(multiplier_if.op_b),
    .multi_out(multiplier_if.multi_out)
);

// Reference model
function logic [31:0] reference_model(logic en, logic [31:0] prev_out, logic [15:0] op_a, logic [15:0] op_b);
    if (en)
        return op_a * op_b;
    else
        return prev_out;
endfunction

// Check function scores the results (Scoreboard)
function void check(logic [31:0] dut_out, logic [31:0] ref_out, logic en, logic [15:0] op_a, logic [15:0] op_b);
    if (dut_out === ref_out)
        pass_count++;
    else begin
        fail_count++;
        $display("[ERROR] time=%0t en=%b op_a=%d op_b=%d | DUT=%b REF=%b",
                 $time, en, op_a, op_b, dut_out, ref_out);
    end
endfunction

// Test sequence, stimulus generation

initial begin
    $display("========= Initial tests =========");

    // Initialize interface signals (Reset)
    multiplier_if.reset_n = 0;
    multiplier_if.en = 0;
    multiplier_if.op_a = 0;
    multiplier_if.op_b = 0;
    expected = 0;

    repeat (2) @(posedge clk);
    multiplier_if.reset_n = 1;

    // Check one cycle after reset release
    @(posedge clk); #1;

    expected = reference_model(multiplier_if.en, expected, multiplier_if.op_a, multiplier_if.op_b);
    check(multiplier_if.multi_out, expected, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);

    multiplier_if.en = 1;
    repeat (100) begin
        @(negedge clk);
        multiplier_if.op_a = $urandom_range(0, 65535);
        multiplier_if.op_b = $urandom_range(0, 65535);

        @(posedge clk); #1;
        expected_next = reference_model(multiplier_if.en, expected, multiplier_if.op_a, multiplier_if.op_b);
        check(multiplier_if.multi_out, expected_next, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);
        expected = expected_next;
    end

    multiplier_if.en = 0;
    repeat (100) begin
        @(negedge clk);
        multiplier_if.op_a = $urandom_range(0, 65535);
        multiplier_if.op_b = $urandom_range(0, 65535);

        @(posedge clk); #1;
        expected_next = reference_model(multiplier_if.en, expected, multiplier_if.op_a, multiplier_if.op_b);
        check(multiplier_if.multi_out, expected_next, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);
        expected = expected_next;
    end

    // Directed test cases with enable asserted
    // These vectors help validar casos de fronteira e comportamento exato do multiplicador.
    multiplier_if.en = 1;

    @(negedge clk);
    multiplier_if.op_a = 16'h0000;
    multiplier_if.op_b = 16'h1234; // zero multiplicand
    @(posedge clk); #1;
    expected_next = reference_model(multiplier_if.en, expected, multiplier_if.op_a, multiplier_if.op_b);
    check(multiplier_if.multi_out, expected_next, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);
    expected = expected_next;

    @(negedge clk);
    multiplier_if.op_a = 16'h0001;
    multiplier_if.op_b = 16'hFFFF; // identity case
    @(posedge clk); #1;
    expected_next = reference_model(multiplier_if.en, expected, multiplier_if.op_a, multiplier_if.op_b);
    check(multiplier_if.multi_out, expected_next, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);
    expected = expected_next;

    @(negedge clk);
    multiplier_if.op_a = 16'h0002;
    multiplier_if.op_b = 16'h8000; // high bit multiplication
    @(posedge clk); #1;
    expected_next = reference_model(multiplier_if.en, expected, multiplier_if.op_a, multiplier_if.op_b);
    check(multiplier_if.multi_out, expected_next, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);
    expected = expected_next;

    @(negedge clk);
    multiplier_if.op_a = 16'h7FFF;
    multiplier_if.op_b = 16'h7FFF; // large positive values
    @(posedge clk); #1;
    expected_next = reference_model(multiplier_if.en, expected, multiplier_if.op_a, multiplier_if.op_b);
    check(multiplier_if.multi_out, expected_next, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);
    expected = expected_next;

    @(negedge clk);
    multiplier_if.op_a = 16'hFFFF;
    multiplier_if.op_b = 16'hFFFF; // max operands
    @(posedge clk); #1;
    expected_next = reference_model(multiplier_if.en, expected, multiplier_if.op_a, multiplier_if.op_b);
    check(multiplier_if.multi_out, expected_next, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);
    expected = expected_next;

    // Reset behavior test: quando reset_n é ativo, saída deve voltar para zero
    multiplier_if.en = 1;
    multiplier_if.op_a = 16'h1234;
    multiplier_if.op_b = 16'h0002;
    @(negedge clk);
    multiplier_if.reset_n = 0;
    @(posedge clk); #1;
    expected = 32'd0;
    check(multiplier_if.multi_out, expected, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);
    multiplier_if.reset_n = 1;
    @(posedge clk); #1;
    expected_next = reference_model(multiplier_if.en, expected, multiplier_if.op_a, multiplier_if.op_b);
    check(multiplier_if.multi_out, expected_next, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);
    expected = expected_next;

    // Enable low hold behavior: com enable = 0, o valor anterior deve ser preservado
    multiplier_if.en = 1;
    @(negedge clk);
    multiplier_if.op_a = 16'h0003;
    multiplier_if.op_b = 16'h0004;
    @(posedge clk); #1;
    expected = reference_model(multiplier_if.en, expected, multiplier_if.op_a, multiplier_if.op_b);
    check(multiplier_if.multi_out, expected, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);

    multiplier_if.en = 0;
    multiplier_if.op_a = 16'hAAAA;
    multiplier_if.op_b = 16'hBBBB;
    @(posedge clk); #1;
    expected_next = reference_model(multiplier_if.en, expected, multiplier_if.op_a, multiplier_if.op_b);
    check(multiplier_if.multi_out, expected_next, multiplier_if.en, multiplier_if.op_a, multiplier_if.op_b);
    expected = expected_next;

    $display("\n===================== SUMMARY =====================");
    $display("PASS: %d", pass_count);
    $display("FAIL: %d", fail_count);
    $display("====================================================\n");
    $finish;
end

// FSDB dump for waveform viewing
initial begin
    $fsdbDumpfile("multiplier16x16.fsdb");
    $fsdbDumpvars();
end

endmodule