module adder_tb;

    // Signals
    logic         clk;
    logic         reset_n;
    logic         en;
    logic [31:0]  op_a;
    logic [31:0]  op_b;
    logic [31:0]  adder_out;
    logic         carry_out;
    logic [32:0]  expected;

    // Scoreboard Counters
    int pass_count = 0;
    int fail_count = 0;

    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk;

    // DUT Instance
    adder dut (
        .clk        (clk),
        .reset_n    (reset_n),
        .en         (en),
        .op_a       (op_a),
        .op_b       (op_b),
        .adder_out  (adder_out),
        .carry_out  (carry_out)
    );

    // Reference Model
    function logic [32:0] reference_model (
        input logic         en,
        input logic [31:0]  a,
        input logic [31:0]  b,
        input logic [32:0]  prev
    );
        if (en) begin
            return a + b;
        end 
        else begin
            return prev;
        end

    endfunction

    // Scoreboard Check
    function void check (
        input logic [31:0] dut_out,
        input logic        dut_carry,
        input logic [31:0] ref_out,
        input logic        ref_carry,
        input logic         en,
        input logic [31:0]  a,
        input logic [31:0]  b
    );

        if ((dut_out === ref_out) && (dut_carry === ref_carry)) begin
            pass_count++;
        end
        else begin
            fail_count++;
            $display(
                "[ERROR] time=%0t en=%b a=%h b=%h | DUT=%h C=%b REF=%h C=%b",
                $time, en, a, b, dut_out, dut_carry, ref_out, ref_carry );
        end

    endfunction

    // Stimulus
    initial begin

        $display("============= INITIAL TESTS =============");

        // Initial values
        reset_n = 0;
        en      = 0;
        op_a    = 0;
        op_b    = 0;
        expected = 0;

        // Apply reset
        repeat (2) @(posedge clk);
        reset_n = 1;
        // Wait one cycle
        @(posedge clk);
        #1;
        // Expected output
        expected = reference_model(en, op_a, op_b, expected);

        // Check outputs
        check(adder_out, carry_out, expected[31:0], expected[32],
              en, op_a, op_b);

        // Enable Tests
        en = 1;

        repeat (100) begin

            @(negedge clk);

            // Random stimulus
            op_a = $urandom();
            op_b = $urandom();

            @(posedge clk);
            #1;

            // Reference model
            expected = reference_model(en, op_a, op_b, expected);

            // Check DUT
            check(adder_out, carry_out, expected[31:0], expected[32],
                  en, op_a, op_b);

        end

        // Disable Tests
        en = 0;

        expected = {carry_out, adder_out};

        repeat (100) begin

            @(negedge clk);

            // Random stimulus
            op_a = $urandom();
            op_b = $urandom();

            @(posedge clk);
            #1;

            // Reference model
            expected = reference_model(en, op_a, op_b, expected);

            // Check DUT
            check(adder_out, carry_out, expected[31:0], expected[32],
                  en, op_a, op_b);

        end

        // Edge Case Tests
        $display("\n============= EDGE CASE TESTS =============");
        en = 1;
        
        // Overflow test: 0xFFFFFFFF + 0x00000001 = 0x1_00000000 (carry out)
        op_a = 32'hFFFFFFFF;
        op_b = 32'h00000001;
        @(posedge clk); #1;
        expected = reference_model(en, op_a, op_b, expected);
        check(adder_out, carry_out, expected[31:0], expected[32], en, op_a, op_b);
        
        // Zero test: 0 + 0 = 0
        op_a = 32'h00000000;
        op_b = 32'h00000000;
        @(posedge clk); #1;
        expected = reference_model(en, op_a, op_b, expected);
        check(adder_out, carry_out, expected[31:0], expected[32], en, op_a, op_b);
        
        // Max test: 0xFFFFFFFF + 0xFFFFFFFF = 0x1_FFFFFFFE (max overflow)
        op_a = 32'hFFFFFFFF;
        op_b = 32'hFFFFFFFF;
        @(posedge clk); #1;
        expected = reference_model(en, op_a, op_b, expected);
        check(adder_out, carry_out, expected[31:0], expected[32], en, op_a, op_b);
        
        // Simple test: 0x00000001 + 0x00000001 = 0x00000002
        op_a = 32'h00000001;
        op_b = 32'h00000001;
        @(posedge clk); #1;
        expected = reference_model(en, op_a, op_b, expected);
        check(adder_out, carry_out, expected[31:0], expected[32], en, op_a, op_b);
        
        // Alternating bits test: 0xAAAAAAAA + 0x55555555 = 0xFFFFFFFF
        op_a = 32'hAAAAAAAA;
        op_b = 32'h55555555;
        @(posedge clk); #1;
        expected = reference_model(en, op_a, op_b, expected);
        check(adder_out, carry_out, expected[31:0], expected[32], en, op_a, op_b);
        
        // Half max: 0x80000000 + 0x80000000 = 0x1_00000000 (carry out)
        op_a = 32'h80000000;
        op_b = 32'h80000000;
        @(posedge clk); #1;
        expected = reference_model(en, op_a, op_b, expected);
        check(adder_out, carry_out, expected[31:0], expected[32], en, op_a, op_b);

        // Toggle Enable Tests
        $display("\n============= TOGGLE ENABLE TESTS =============");
        
        repeat (50) begin
            en = ~en;  // Toggle en
            op_a = $urandom();
            op_b = $urandom();
            @(posedge clk);
            #1;
            expected = reference_model(en, op_a, op_b, expected);
            check(adder_out, carry_out, expected[31:0], expected[32], en, op_a, op_b);
        end

        // Reset During Operation Test
        $display("\n========== RESET DURING OPERATION ==========");
        en = 1;
        op_a = 32'hAAAAAAAA;
        op_b = 32'h55555555;
        @(posedge clk); #1;
        
        // Disable en before reset to avoid re-computation
        en = 0;
        
        // Reset in the middle
        reset_n = 0;
        @(posedge clk);
        reset_n = 1;
        @(posedge clk); #1;
        
        // After reset, should have 0
        expected = 0;
        check(adder_out, carry_out, expected[31:0], expected[32], en, op_a, op_b);

        // Summary
        $display("\n================ SUMMARY ================");
        $display("PASS: %0d", pass_count);
        $display("FAIL: %0d", fail_count);
        $display("=========================================\n");

        $finish;

    end

    // FSDB Dump
    initial begin
        $fsdbDumpfile("adder32.fsdb");
        $fsdbDumpvars(0, adder_tb);
    end

endmodule