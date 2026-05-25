interface robot_if(input logic clk);

    logic reset_n;

    logic s0_req;
    logic s1_req;
    logic s2_req;
    logic s3_req;

    logic s0_unloadstart;
    logic s1_unloadstart;
    logic s2_unloadstart;
    logic s3_unloadstart;

    logic s0_unload_done;
    logic s1_unload_done;
    logic s2_unload_done;
    logic s3_unload_done;

    logic load_start;

endinterface

module robot_model_tb;

    logic clk = 0;

    robot_if rb_if(clk);

    int pass_count = 0;
    int fail_count = 0;

    logic exp_load_start;
    logic exp_s0_unloadstart;
    logic exp_s1_unloadstart;
    logic exp_s2_unloadstart;
    logic exp_s3_unloadstart;

    bit main_state_seen   [4];
    bit load_state_seen   [4];
    bit unload_state_seen [8];

    typedef enum logic [1:0] {
        REF_M_WAIT_REQ = 2'd0,
        REF_M_S0_S1    = 2'd1,
        REF_M_S2_S3    = 2'd2
    } ref_main_state_e;

    typedef enum logic [1:0] {
        REF_L_IDLE       = 2'd0,
        REF_L_WRIST_HOR  = 2'd1,
        REF_L_LOAD_ITEM  = 2'd2,
        REF_L_WRIST_VERT = 2'd3
    } ref_load_state_e;

    typedef enum logic [2:0] {
        REF_U_IDLE         = 3'd0,
        REF_U_JOINTA_RIGHT = 3'd1,
        REF_U_JOINTC_DOWN  = 3'd2,
        REF_U_RELEASE_CLAW = 3'd3,
        REF_U_JOINTC_UP    = 3'd4,
        REF_U_JOINTA_LEFT  = 3'd5
    } ref_unload_state_e;

    ref_main_state_e   ref_main_state;
    ref_load_state_e   ref_load_state;
    ref_unload_state_e ref_unload_state;
    int                ref_station;

    always #5 clk = ~clk;

    robot_model dut (
        .clock           (rb_if.clk),
        .reset_n         (rb_if.reset_n),

        .s0_req          (rb_if.s0_req),
        .s1_req          (rb_if.s1_req),
        .s2_req          (rb_if.s2_req),
        .s3_req          (rb_if.s3_req),

        .s0_unloadstart  (rb_if.s0_unloadstart),
        .s1_unloadstart  (rb_if.s1_unloadstart),
        .s2_unloadstart  (rb_if.s2_unloadstart),
        .s3_unloadstart  (rb_if.s3_unloadstart),

        .s0_unload_done  (rb_if.s0_unload_done),
        .s1_unload_done  (rb_if.s1_unload_done),
        .s2_unload_done  (rb_if.s2_unload_done),
        .s3_unload_done  (rb_if.s3_unload_done),

        .load_start      (rb_if.load_start)
    );

    function automatic logic [3:0] req_vec();
        req_vec = {rb_if.s3_req, rb_if.s2_req, rb_if.s1_req, rb_if.s0_req};
    endfunction

    function automatic logic [3:0] done_vec();
        done_vec = {
            rb_if.s3_unload_done,
            rb_if.s2_unload_done,
            rb_if.s1_unload_done,
            rb_if.s0_unload_done
        };
    endfunction

    function automatic logic [3:0] unloadstart_vec();
        unloadstart_vec = {
            rb_if.s3_unloadstart,
            rb_if.s2_unloadstart,
            rb_if.s1_unloadstart,
            rb_if.s0_unloadstart
        };
    endfunction

    function automatic logic [3:0] exp_unloadstart_vec();
        exp_unloadstart_vec = {
            exp_s3_unloadstart,
            exp_s2_unloadstart,
            exp_s1_unloadstart,
            exp_s0_unloadstart
        };
    endfunction

    function automatic bit onehot4(input logic [3:0] value);
        onehot4 = (value == 4'b0001) ||
                  (value == 4'b0010) ||
                  (value == 4'b0100) ||
                  (value == 4'b1000);
    endfunction

    function automatic int station_from_req(input logic [3:0] value);
        case (value)
            4'b0001: station_from_req = 0;
            4'b0010: station_from_req = 1;
            4'b0100: station_from_req = 2;
            4'b1000: station_from_req = 3;
            default: station_from_req = -1;
        endcase
    endfunction

    function automatic bit station_needs_joint_c(input int station);
        station_needs_joint_c = (station == 1) || (station == 3);
    endfunction

    function automatic bit station_done(input int station, input logic [3:0] value);
        station_done = ((station >= 0) && (station < 4)) ? value[station] : 1'b0;
    endfunction

    task automatic reset_reference_model();
        ref_main_state   = REF_M_WAIT_REQ;
        ref_load_state   = REF_L_IDLE;
        ref_unload_state = REF_U_IDLE;
        ref_station      = -1;
    endtask

    task automatic update_expected_outputs();
        exp_load_start     = (ref_load_state == REF_L_WRIST_HOR);
        exp_s0_unloadstart = 1'b0;
        exp_s1_unloadstart = 1'b0;
        exp_s2_unloadstart = 1'b0;
        exp_s3_unloadstart = 1'b0;

        if ((ref_station >= 0) &&
            ((ref_load_state == REF_L_WRIST_VERT) ||
             (ref_unload_state != REF_U_IDLE))) begin
            case (ref_station)
                0: exp_s0_unloadstart = 1'b1;
                1: exp_s1_unloadstart = 1'b1;
                2: exp_s2_unloadstart = 1'b1;
                3: exp_s3_unloadstart = 1'b1;
            endcase
        end
    endtask

    task automatic reference_model_step();
        ref_main_state_e   next_main_state;
        ref_load_state_e   next_load_state;
        ref_unload_state_e next_unload_state;
        int                next_station;
        logic [3:0]        reqs;
        logic [3:0]        dones;

        reqs  = req_vec();
        dones = done_vec();

        if (!rb_if.reset_n) begin
            reset_reference_model();
            update_expected_outputs();
            return;
        end

        next_main_state   = ref_main_state;
        next_load_state   = ref_load_state;
        next_unload_state = ref_unload_state;
        next_station      = ref_station;

        case (ref_main_state)
            REF_M_WAIT_REQ: begin
                if (onehot4(reqs) && (reqs[0] || reqs[1]))
                    next_main_state = REF_M_S0_S1;
                else if (onehot4(reqs) && (reqs[2] || reqs[3]))
                    next_main_state = REF_M_S2_S3;
                else
                    next_main_state = REF_M_WAIT_REQ;
            end

            REF_M_S0_S1,
            REF_M_S2_S3: begin
                if (dones != 4'b0000)
                    next_main_state = REF_M_WAIT_REQ;
            end

            default:
                next_main_state = REF_M_WAIT_REQ;
        endcase

        case (ref_load_state)
            REF_L_IDLE: begin
                if ((ref_station < 0) && onehot4(reqs)) begin
                    next_station    = station_from_req(reqs);
                    next_load_state = REF_L_WRIST_HOR;
                end
            end

            REF_L_WRIST_HOR:
                next_load_state = REF_L_LOAD_ITEM;

            REF_L_LOAD_ITEM:
                next_load_state = REF_L_WRIST_VERT;

            REF_L_WRIST_VERT:
                next_load_state = REF_L_IDLE;

            default:
                next_load_state = REF_L_IDLE;
        endcase

        case (ref_unload_state)
            REF_U_IDLE: begin
                if (ref_load_state == REF_L_WRIST_VERT)
                    next_unload_state = REF_U_JOINTA_RIGHT;
            end

            REF_U_JOINTA_RIGHT: begin
                if (station_needs_joint_c(ref_station))
                    next_unload_state = REF_U_JOINTC_DOWN;
                else
                    next_unload_state = REF_U_RELEASE_CLAW;
            end

            REF_U_JOINTC_DOWN:
                next_unload_state = REF_U_RELEASE_CLAW;

            REF_U_RELEASE_CLAW: begin
                if (station_needs_joint_c(ref_station))
                    next_unload_state = REF_U_JOINTC_UP;
                else if (station_done(ref_station, dones))
                    next_unload_state = REF_U_JOINTA_LEFT;
            end

            REF_U_JOINTC_UP: begin
                if (station_done(ref_station, dones))
                    next_unload_state = REF_U_JOINTA_LEFT;
            end

            REF_U_JOINTA_LEFT: begin
                next_unload_state = REF_U_IDLE;
                next_station      = -1;
            end

            default:
                next_unload_state = REF_U_IDLE;
        endcase

        ref_main_state   = next_main_state;
        ref_load_state   = next_load_state;
        ref_unload_state = next_unload_state;
        ref_station      = next_station;

        update_expected_outputs();
    endtask

    task automatic record_state_coverage();
        main_state_seen[dut.curr_state] = 1'b1;
        load_state_seen[dut.load_cstate] = 1'b1;
        unload_state_seen[{1'b0, dut.unload_cstate}] = 1'b1;
    endtask

    task automatic print_signal_table();
        $display("Signal table:");
        $display("+------------------+-------------------------------------------------------------+");
        $display("| Column           | Signals                                                     |");
        $display("+------------------+-------------------------------------------------------------+");
        $display("| req[3:0]         | s3_req s2_req s1_req s0_req                                 |");
        $display("| done[3:0]        | s3_unload_done s2_unload_done s1_unload_done s0_unload_done |");
        $display("| unload[3:0]      | s3_unloadstart s2_unloadstart s1_unloadstart s0_unloadstart |");
        $display("| main/load/unload | dut.curr_state dut.load_cstate dut.unload_cstate            |");
        $display("+------------------+-------------------------------------------------------------+");
        $display("Main FSM: WAIT_REQ=00, S0/S1=01, S2/S3=10");
        $display("Load FSM: IDLE=00, WRIST_HOR=01, LOAD_ITEM=10, WRIST_VERT=11");
        $display("Unload FSM: IDLE=000, JOINTA_RIGHT=001, JOINTC_DOWN=010,");
        $display("            RELEASE_CLAW=011, JOINTC_UP=100, JOINTA_LEFT=101\n");
    endtask

    task automatic check(input string test_name);
        bit outputs_ok;
        bit states_ok;

        record_state_coverage();

        outputs_ok = (rb_if.load_start      === exp_load_start) &&
                     (rb_if.s0_unloadstart  === exp_s0_unloadstart) &&
                     (rb_if.s1_unloadstart  === exp_s1_unloadstart) &&
                     (rb_if.s2_unloadstart  === exp_s2_unloadstart) &&
                     (rb_if.s3_unloadstart  === exp_s3_unloadstart);

        states_ok = (dut.curr_state    === ref_main_state) &&
                    (dut.load_cstate   === ref_load_state) &&
                    (dut.unload_cstate === ref_unload_state);

        if (outputs_ok && states_ok) begin
            pass_count++;
            $display("[PASS] %-32s t=%0t req=%04b done=%04b | DUT out=(load=%0b unload=%04b) st=(%02b,%02b,%03b) | REF out=(load=%0b unload=%04b) st=(%02b,%02b,%03b)",
                test_name,
                $time,
                req_vec(),
                done_vec(),
                rb_if.load_start,
                unloadstart_vec(),
                dut.curr_state,
                dut.load_cstate,
                dut.unload_cstate,
                exp_load_start,
                exp_unloadstart_vec(),
                ref_main_state,
                ref_load_state,
                ref_unload_state);
        end
        else begin
            fail_count++;
            $display("[FAIL] %-32s t=%0t req=%04b done=%04b | DUT out=(load=%0b unload=%04b) st=(%02b,%02b,%03b) | REF out=(load=%0b unload=%04b) st=(%02b,%02b,%03b)",
                test_name,
                $time,
                req_vec(),
                done_vec(),
                rb_if.load_start,
                unloadstart_vec(),
                dut.curr_state,
                dut.load_cstate,
                dut.unload_cstate,
                exp_load_start,
                exp_unloadstart_vec(),
                ref_main_state,
                ref_load_state,
                ref_unload_state);
        end
    endtask

    task automatic check_static_rtl_properties();
        if ($bits(dut.curr_state) == 2) begin
            pass_count++;
            $display("[PASS] MAIN_STATE_WIDTH              t=%0t width=%0d", $time, $bits(dut.curr_state));
        end
        else begin
            fail_count++;
            $display("[FAIL] MAIN_STATE_WIDTH              t=%0t width=%0d expected=2", $time, $bits(dut.curr_state));
        end

        if ($bits(dut.load_cstate) == 2) begin
            pass_count++;
            $display("[PASS] LOAD_STATE_WIDTH              t=%0t width=%0d", $time, $bits(dut.load_cstate));
        end
        else begin
            fail_count++;
            $display("[FAIL] LOAD_STATE_WIDTH              t=%0t width=%0d expected=2", $time, $bits(dut.load_cstate));
        end

        if ($bits(dut.unload_cstate) == 3) begin
            pass_count++;
            $display("[PASS] UNLOAD_STATE_WIDTH            t=%0t width=%0d", $time, $bits(dut.unload_cstate));
        end
        else begin
            fail_count++;
            $display("[FAIL] UNLOAD_STATE_WIDTH            t=%0t width=%0d expected=3", $time, $bits(dut.unload_cstate));
        end
    endtask

    task automatic drive_inputs(
        input logic [3:0] reqs,
        input logic [3:0] dones
    );
        rb_if.s0_req = reqs[0];
        rb_if.s1_req = reqs[1];
        rb_if.s2_req = reqs[2];
        rb_if.s3_req = reqs[3];

        rb_if.s0_unload_done = dones[0];
        rb_if.s1_unload_done = dones[1];
        rb_if.s2_unload_done = dones[2];
        rb_if.s3_unload_done = dones[3];
    endtask

    task automatic drive_and_check(
        input logic [3:0] reqs,
        input logic [3:0] dones,
        input string      test_name
    );
        @(negedge clk);
        drive_inputs(reqs, dones);

        @(posedge clk); #1;
        reference_model_step();
        check(test_name);
    endtask

    task automatic apply_reset();
        @(negedge clk);
        rb_if.reset_n = 1'b0;
        drive_inputs(4'b0000, 4'b0000);
        reset_reference_model();
        update_expected_outputs();

        repeat (2) begin
            @(posedge clk); #1;
            reference_model_step();
            check("RESET");
        end

        @(negedge clk);
        rb_if.reset_n = 1'b1;
    endtask

    task automatic run_valid_request_encoding_tests();
        $display("\n========== VALID ONE-HOT REQUEST ENCODINGS ==========");

        for (int station = 0; station < 4; station++) begin
            apply_reset();
            drive_and_check(4'b0001 << station, 4'b0000,
                            $sformatf("VALID_ONEHOT_S%0d", station));
        end
    endtask

    task automatic run_invalid_request_encoding_tests();
        logic [3:0] reqs;

        $display("\n========== OUT-OF-SPEC REQUEST ENCODINGS ==========");

        apply_reset();
        drive_and_check(4'b0000, 4'b0000, "NO_REQUEST_STAYS_IDLE");

        for (int value = 0; value < 16; value++) begin
            reqs = value[3:0];

            if ((reqs != 4'b0000) && !onehot4(reqs)) begin
                apply_reset();
                drive_and_check(reqs, 4'b0000, "MULTIPLE_REQ_IGNORED");
                drive_and_check(4'b0000, 4'b0000, "MULTIPLE_REQ_BACK_IDLE");
            end
        end
    endtask

    task automatic run_done_without_request_tests();
        $display("\n========== OUT-OF-SPEC DONE WITHOUT REQUEST ==========");

        for (int station = 0; station < 4; station++) begin
            apply_reset();
            drive_and_check(4'b0000, 4'b0001 << station,
                            $sformatf("DONE_WITHOUT_REQ_S%0d", station));
            drive_and_check(4'b0000, 4'b0000,
                            $sformatf("DONE_WITHOUT_REQ_S%0d_CLEAR", station));
        end
    endtask

    task automatic run_station_sequence(input int station, input bit hold_req);
        logic [3:0] reqs;
        logic [3:0] dones;
        string      test_name;

        reqs  = 4'b0001 << station;
        dones = 4'b0000;

        apply_reset();

        if (hold_req)
            test_name = $sformatf("S%0d_HELD_REQ", station);
        else
            test_name = $sformatf("S%0d_PULSE_REQ", station);

        $display("\n========== %s ==========", test_name);

        drive_and_check(reqs, dones, {test_name, "_LOAD_START"});

        if (!hold_req)
            reqs = 4'b0000;

        drive_and_check(reqs, dones, {test_name, "_LOAD_ITEM"});
        drive_and_check(reqs, dones, {test_name, "_WRIST_VERT"});
        drive_and_check(reqs, dones, {test_name, "_JOINTA_RIGHT"});

        if (station_needs_joint_c(station))
            drive_and_check(reqs, dones, {test_name, "_JOINTC_DOWN"});

        drive_and_check(reqs, dones, {test_name, "_RELEASE_CLAW"});

        if (station_needs_joint_c(station))
            drive_and_check(reqs, dones, {test_name, "_JOINTC_UP"});

        dones = 4'b0001 << station;
        drive_and_check(reqs, dones, {test_name, "_DONE"});

        reqs  = 4'b0000;
        dones = 4'b0000;
        drive_and_check(reqs, dones, {test_name, "_JOINTA_LEFT"});
        drive_and_check(reqs, dones, {test_name, "_BACK_IDLE"});
    endtask

    task automatic run_wrong_done_sequence(input int station);
        logic [3:0] reqs;
        logic [3:0] dones;
        int         wrong_station;

        reqs          = 4'b0001 << station;
        dones         = 4'b0000;
        wrong_station = (station + 1) % 4;

        apply_reset();

        $display("\n========== WRONG DONE DURING S%0d SERVICE ==========", station);

        drive_and_check(reqs, dones, "WRONG_DONE_LOAD_START");
        drive_and_check(reqs, dones, "WRONG_DONE_LOAD_ITEM");
        drive_and_check(reqs, dones, "WRONG_DONE_WRIST_VERT");
        drive_and_check(reqs, dones, "WRONG_DONE_JOINTA_RIGHT");

        if (station_needs_joint_c(station))
            drive_and_check(reqs, dones, "WRONG_DONE_JOINTC_DOWN");

        drive_and_check(reqs, 4'b0001 << wrong_station, "WRONG_DONE_IGNORED");
        drive_and_check(reqs, dones, "WRONG_DONE_STILL_WAITING");

        if (station_needs_joint_c(station))
            drive_and_check(reqs, dones, "WRONG_DONE_JOINTC_UP");

        dones = 4'b0001 << station;
        drive_and_check(reqs, dones, "RIGHT_DONE_ACCEPTED");
    endtask

    task automatic run_request_changes_during_operation();
        $display("\n========== OUT-OF-SPEC REQUEST CHANGES DURING OPERATION ==========");

        apply_reset();

        drive_and_check(4'b0001, 4'b0000, "REQ_CHANGE_S0_START");
        drive_and_check(4'b0010, 4'b0000, "REQ_CHANGE_TO_S1_IGNORED");
        drive_and_check(4'b0100, 4'b0000, "REQ_CHANGE_TO_S2_IGNORED");
        drive_and_check(4'b1000, 4'b0000, "REQ_CHANGE_TO_S3_IGNORED");
        drive_and_check(4'b0000, 4'b0000, "REQ_CHANGE_RELEASE_REQ");
        drive_and_check(4'b0000, 4'b0001, "REQ_CHANGE_S0_DONE");
        drive_and_check(4'b0000, 4'b0000, "REQ_CHANGE_BACK_IDLE");
    endtask

    task automatic run_all_station_sequences();
        $display("\n========== DIRECTED FSM TRANSITIONS ==========");

        for (int station = 0; station < 4; station++)
            run_station_sequence(station, 1'b1);

        for (int station = 0; station < 4; station++)
            run_station_sequence(station, 1'b0);
    endtask

    task automatic print_state_coverage();
        $display("\n========== STATE ENCODING COVERAGE ==========");
        for (int i = 0; i < 4; i++)
            $display("main_state[%0d]=%0b load_state[%0d]=%0b",
                     i, main_state_seen[i], i, load_state_seen[i]);

        for (int i = 0; i < 8; i++)
            $display("unload_state[%0d]=%0b", i, unload_state_seen[i]);

        $display("\n========== STATE ENCODING CHECKS ==========");

        for (int i = 0; i <= 2; i++) begin
            if (main_state_seen[i]) begin
                pass_count++;
                $display("[PASS] MAIN_STATE_ENCODING_%0d       observed", i);
            end
            else begin
                fail_count++;
                $display("[FAIL] MAIN_STATE_ENCODING_%0d       not observed", i);
            end
        end

        for (int i = 0; i <= 3; i++) begin
            if (load_state_seen[i]) begin
                pass_count++;
                $display("[PASS] LOAD_STATE_ENCODING_%0d       observed", i);
            end
            else begin
                fail_count++;
                $display("[FAIL] LOAD_STATE_ENCODING_%0d       not observed", i);
            end
        end

        for (int i = 0; i <= 5; i++) begin
            if (unload_state_seen[i]) begin
                pass_count++;
                $display("[PASS] UNLOAD_STATE_ENCODING_%0d     observed", i);
            end
            else begin
                fail_count++;
                $display("[FAIL] UNLOAD_STATE_ENCODING_%0d     not observed", i);
            end
        end
    endtask

    initial begin
        $display("\n========================================");
        $display("        ROBOT SELF-CHECKING TB");
        $display("========================================\n");

        print_signal_table();

        rb_if.reset_n = 1'b0;
        drive_inputs(4'b0000, 4'b0000);
        reset_reference_model();
        update_expected_outputs();

        check_static_rtl_properties();

        apply_reset();

        run_valid_request_encoding_tests();
        run_invalid_request_encoding_tests();
        run_done_without_request_tests();
        run_all_station_sequences();

        for (int station = 0; station < 4; station++)
            run_wrong_done_sequence(station);

        run_request_changes_during_operation();

        print_state_coverage();

        $display("\n================ SUMMARY ================");
        $display("PASS: %0d", pass_count);
        $display("FAIL: %0d", fail_count);
        $display("=========================================\n");

        #50;
        $finish;
    end

    initial begin
        $fsdbDumpfile("robot_model.fsdb");
        $fsdbDumpvars(0, robot_model_tb);
    end

endmodule
