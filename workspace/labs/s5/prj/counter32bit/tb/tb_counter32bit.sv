module counter_overflow_tb;

    // Signals
    logic clk;
    logic reset_n;
    logic en;
    logic load;
    logic [31:0] counter_out;
    logic        counter_overflow;
    logic [32:0] expected;

    // Scoreboard
    int pass_count = 0;
    int fail_count = 0;

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    // DUT
    counter_overflow dut (
        .clk(clk),
        .reset_n(reset_n),
        .en(en),
        .load(load),
        .counter_out(counter_out),
        .counter_overflow(counter_overflow)
    );

    // Reference Model
    function logic [32:0] reference_model(
        input logic        en,
        input logic        load,
        input logic [32:0] prev
    );

        logic [32:0] temp;
        temp = prev;
        if (load) begin
            temp = 33'h1FFFFFFF8;
        end
        if (en) begin
            temp = prev + 1;
        end
        return temp;

    endfunction

    // Check Task
    task check;
        if ((counter_out === expected[31:0]) && (counter_overflow === expected[32])) begin
            pass_count++;
        end
        else begin
            fail_count++;
            $display(
                "[ERROR] t=%0t en=%0b load=%0b | DUT=%h OF=%0b | EXP=%h OF=%0b",
                $time, en, load, counter_out, counter_overflow, expected[31:0], expected[32] );
        end
    endtask

    // Stimulus
    initial begin

        // init
        reset_n = 0;
        en      = 0;
        load    = 0;
        expected = 0;

        // reset
        repeat(2) @(posedge clk);
        reset_n = 1;
        @(posedge clk);
        #1;
        expected = 0;
        check();

        // Random tests
        repeat (200) begin
            @(negedge clk);
            en   = $urandom_range(0,1);
            load = $urandom_range(0,1);
            @(posedge clk);
            #1;
            expected = reference_model(en, load, expected);
            check();

        end

        // Summary
        $display("\n============= SUMMARY =============");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("===================================\n");
        $finish;

    end

    // FSDB
    initial begin
        $fsdbDumpfile("counter32bit.fsdb");
        $fsdbDumpvars(0, counter_overflow_tb);
    end

endmodule