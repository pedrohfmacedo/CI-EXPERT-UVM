module updown_counter_tb;
    logic clk;
    logic resetn;
    logic en;

    logic [3:0] up_counter;
    logic [3:0] down_counter;

    logic [3:0] exp_up_counter;
    logic [3:0] exp_down_counter;

    // Scoreboard
    int pass_count = 0;
    int fail_count = 0;

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    // DUT
    updowncounter dut (
        .clk(clk),
        .resetn(resetn),
        .en(en),
        .up_counter(up_counter),
        .down_counter(down_counter)
    );

    // Reference model
    function logic [7:0] reference_model(
        input logic       resetn,
        input logic       en,
        input logic [3:0] prev_up,
        input logic [3:0] prev_down
    );

        if (!resetn)
            reference_model = {4'b1111, 4'b0000};
        else if (en)
            reference_model = {prev_down - 4'b0001, prev_up + 4'b0001};
        else
            reference_model = {prev_down, prev_up};

    endfunction

    // Check task
    task check;

        if ((up_counter === exp_up_counter) &&
            (down_counter === exp_down_counter)) begin

            pass_count++;

        end
        else begin

            fail_count++;

            $display(
                "[ERROR] time=%0t resetn=%0b en=%0b | DUT up=%0d down=%0d | REF up=%0d down=%0d",
                $time,
                resetn,
                en,
                up_counter,
                down_counter,
                exp_up_counter,
                exp_down_counter
            );

        end

    endtask

    // Stimulus
    initial begin

        $display("========= UP/DOWN COUNTER TESTS =========");

        resetn = 0;
        en = 0;
        exp_up_counter = 4'b0000;
        exp_down_counter = 4'b1111;

        // Reset is sampled by the DUT on the clock edge while resetn is low.
        repeat (2) begin
            @(posedge clk);
            #1;
            {exp_down_counter, exp_up_counter} =
                reference_model(resetn, en, exp_up_counter, exp_down_counter);
            check();
        end

        @(negedge clk);
        resetn = 1;

        @(negedge clk);
        en = 1;

        // Enabled count tests
        repeat (40) begin
            @(posedge clk);
            #1;
            {exp_down_counter, exp_up_counter} =
                reference_model(resetn, en, exp_up_counter, exp_down_counter);
            check();
        end

        // Disable and hold tests
        @(negedge clk);
        en = 0;

        repeat (20) begin
            @(posedge clk);
            #1;
            {exp_down_counter, exp_up_counter} =
                reference_model(resetn, en, exp_up_counter, exp_down_counter);
            check();
        end

        // Reset during operation
        @(negedge clk);
        en = 1;

        repeat (10) begin
            @(posedge clk);
            #1;
            {exp_down_counter, exp_up_counter} =
                reference_model(resetn, en, exp_up_counter, exp_down_counter);
            check();
        end

        @(negedge clk);
        resetn = 0;
        en = 0;

        repeat (2) begin
            @(posedge clk);
            #1;
            {exp_down_counter, exp_up_counter} =
                reference_model(resetn, en, exp_up_counter, exp_down_counter);
            check();
        end

        @(negedge clk);
        resetn = 1;

        // Random enable tests
        repeat (100) begin
            @(negedge clk);
            en = $urandom_range(0, 1);

            @(posedge clk);
            #1;
            {exp_down_counter, exp_up_counter} =
                reference_model(resetn, en, exp_up_counter, exp_down_counter);
            check();
        end

        // Summary
        $display("\n================ SUMMARY ================");
        $display("PASS: %0d", pass_count);
        $display("FAIL: %0d", fail_count);
        $display("==========================================\n");

        $finish;

    end

    initial begin
        $fsdbDumpfile("updown_counter.fsdb");
        $fsdbDumpvars(0, updown_counter_tb);
    end

endmodule
