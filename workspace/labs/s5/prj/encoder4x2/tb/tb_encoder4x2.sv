// Top-level testbench for encoder4x2
module tb_encoder4x2;

    // Interface
    logic clk = 0;
    logic rstn;
    logic en;
    logic [3:0] din;
    logic [1:0] dout;

    // Scoreboard
    logic [1:0] expected;
    int pass_count = 0;
    int fail_count = 0;

    // Clock generation
    always #5 clk = ~clk;

    // Reference model (inverse logic of decoder)
    function logic [1:0] reference_model(logic en, logic [3:0] din, logic [1:0] prev_out);
        if (!en)
            return prev_out;
        case (din)
            4'b0001: return 2'b00;
            4'b0010: return 2'b01;
            4'b0100: return 2'b10;
            4'b1000: return 2'b11;
            default: return 2'b00;
        endcase
    endfunction

    // Check function
    function void check(logic [1:0] dut_out, logic [1:0] ref_out, logic en, logic [3:0] din);
        if (dut_out === ref_out)
            pass_count++;
        else begin
            fail_count++;
            $display("[ERROR] time=%0t en=%b din=%b | DUT=%b REF=%b", $time, en, din, dut_out, ref_out);
        end
    endfunction

    initial begin
        $display("========= Initial tests =========");

        // Reset and initialize
        rstn = 0;
        en = 0;
        din = 4'b0000;
        expected = 2'b00;

        repeat (2) @(posedge clk);
        rstn = 1;
        @(posedge clk); #1;

        // Ensure output holds when enable is low
        din = 4'b0010;
        en = 0;
        @(posedge clk); #1;
        expected = reference_model(en, din, expected);
        check(dout, expected, en, din);

        // Enable valid one-hot inputs
        en = 1;
        foreach (din[i]) begin
            @(negedge clk);
            din = 4'b0001 << i;
            @(posedge clk); #1;
            expected = reference_model(en, din, expected);
            check(dout, expected, en, din);
        end

        // Random valid and invalid inputs with enable asserted
        repeat (50) begin
            @(negedge clk);
            if ($urandom_range(0, 3) < 2)
                din = 4'b0001 << $urandom_range(0, 3);
            else
                din = $urandom_range(0, 15);
            @(posedge clk); #1;
            expected = reference_model(en, din, expected);
            check(dout, expected, en, din);
        end

        // Disable enable and verify hold behavior
        en = 0;
        repeat (20) begin
            @(negedge clk);
            din = $urandom_range(0, 15);
            @(posedge clk); #1;
            expected = reference_model(en, din, expected);
            check(dout, expected, en, din);
        end

        $display("\n===================== SUMMARY =====================");
        $display("PASS: %0d", pass_count);
        $display("FAIL: %0d", fail_count);
        $display("===================================================\n");
        $finish;
    end

    encoder4x2 uut (
        .din(din),
        .clk(clk),
        .dout(dout),
        .rstn(rstn),
        .en(en)
    );

    initial begin
        $dumpfile("encoder4x2.fsdb");
        $dumpvars(0, tb_encoder4x2);
    end

endmodule
