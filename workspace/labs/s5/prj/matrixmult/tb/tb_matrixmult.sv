//Top
module matrix2x2_mult_tb;

logic clk = 0;
logic rstn;
logic en;
logic [31:0] A;
logic [31:0] B;
logic [31:0] Res;
logic [31:0] expected;

// Counter Scoreboard
int pass_count = 0;
int fail_count = 0;

// clock generation
always #5 clk = ~clk; // toggle clock for every 5 ticks

// Instance DUT
matrix2x2_mult dut (
    .A(A), 
    .B(B), 
    .Res(Res),
    .clk(clk),
    .rstn(rstn),
    .en(en)
);

// Reference model
function automatic logic [31:0] reference_model(logic en, logic [31:0] A, logic [31:0] B, logic [31:0] prev_res);
    logic [7:0] a00, a01, a10, a11;
    logic [7:0] b00, b01, b10, b11;
    logic [7:0] r00, r01, r10, r11;
    logic [31:0] result;

    {a00, a01, a10, a11} = A;
    {b00, b01, b10, b11} = B;

    r00 = (a00 * b00) + (a01 * b10);
    r01 = (a00 * b01) + (a01 * b11);
    r10 = (a10 * b00) + (a11 * b10);
    r11 = (a10 * b01) + (a11 * b11);

    result = {r00, r01, r10, r11};

    if (!en)
        return prev_res;
    else
        return result;
endfunction

// Check function scores the results (Scoreboard)
function void check(logic [31:0] dut_out, logic [31:0] ref_out, logic en, logic [31:0] A, logic [31:0] B);
    if (dut_out === ref_out)
        pass_count++;
    else begin
        fail_count++;
        $display("[ERROR] time=%0t en=%b A=%b B=%b | DUT=%b REF=%b",
                 $time, en, A, B, dut_out, ref_out);
    end
endfunction

// Test sequence, stimulus generation

initial begin
 $display("========= Initial tests =========");

    // Initialize interface signals (Reset)
    rstn = 0;
    en = 0;

    repeat (2) @(posedge clk);
    rstn = 1;
    en = 1;
    A = 0;
    B = 0;
    expected = 0;

    // Check one cycle after reset release
    @(posedge clk); #1;
    
    // Get expected output from reference model
    expected = reference_model(en, A, B, expected);

    // Check DUT output against expected output
    check(Res, expected, en, A, B);

    // Loop for tests
    repeat (100) begin

        // Randomize inputs
        @(negedge clk);
        A = $urandom();
        B = $urandom();

        // Wait for the output to stabilize
        @(posedge clk); #1;

        // Get expected output from reference model
        expected = reference_model(en, A, B, expected);

        // Check DUT output against expected output
        check(Res, expected, en, A, B);
    end

    en = 0;
    repeat (100) begin
        // Randomize inputs
        A = $urandom();
        B = $urandom();

        // Wait for the output to stabilize
        @(posedge clk); #1;

        // Get expected output from reference model
        expected = reference_model(en, A, B, expected);

        // Check DUT output against expected output
        check(Res, expected, en, A, B);
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
    $fsdbDumpfile("matrix2x2_mult.fsdb");
    $fsdbDumpvars(0, matrix2x2_mult_tb);
end

endmodule