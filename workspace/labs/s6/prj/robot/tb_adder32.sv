
// TB systemverilog for ADDER

module adder_tb;
  // -------------------------------------------------------
  //
  // DUT Interface (signals to DRIVE DUT and auxiliars)
  //
  // -------------------------------------------------------

  // inputs
  logic clk = 0;
  logic reset_n;
  logic en;
  logic [31:0] A;
  logic [31:0] B;

  // outputs
  logic [31:0] sum;
  logic carry_out;
  logic [32:0] out_dut;

  // -------------------------------------------------------
  //
  // DUT Instanciation
  //
  // -------------------------------------------------------
  adder u_adder(
    .clk(clk),
    .reset_n(reset_n),
    .en(en),
    .op_a(A),
    .op_b(B),
    .adder_out(sum),
    .carry_out(carry_out)
  );

  // -------------------------------------------------------
  //
  // CLOCK GENERATOR (sequential circuit)
  //
  // -------------------------------------------------------
  always #5ns clk = ~clk; // toggle clock for every 5 ticks
  
  // -------------------------------------------------------
  //
  // refmod is Reference Model: 
  // a check where you can compute the expected result
  //
  // -------------------------------------------------------
  longint expected_value_rfm, expected_value_rfm_lastvalue;

  // function longint refmod(longint a, longint b);
  //   return a+b;
  // endfunction: refmod

  task refmod(input longint a, input longint b, input bit verbose_on, output longint expected_value_rfm);
    longint t1;
    longint t2;

    t1 = $realtime;
    if(verbose_on)
      $display("time IN : %t", t1);
    fork
      // p1
      begin: REFMOD
        // #10ns;
        expected_value_rfm = a+b;
      end: REFMOD
      
      // p2
      // begin
      //   #100ns;
      // end
    join
    t2 = $realtime;
    if(verbose_on) begin
      $display("time OUT : %t", t2);
      $display("t2-t1 was %t", t2-t1);
    end
  endtask

  // -------------------------------------------------------
  //
  // MAIN SEQUENCE
  //
  // -------------------------------------------------------
  localparam int NUM_OF_SEQS= 1000;
  localparam int STEP = NUM_OF_SEQS/10;
  logic [31:0] A_lastvalue;
  logic [31:0] B_lastvalue;

  initial begin
    int tr = 0, match=0, mismatch=0;
    int pct;
    int filled;
    reset_n = 1;
    en = 0;


    $display("Test started...");

    // reset
    #10 reset_n = 0;
    #10 reset_n = 1;
    en = 0;

    // main sequence
    $display("\nStarting sequence...\n");
    repeat(NUM_OF_SEQS) begin
      // GENERATOR Function
      // input : NONE.
      // output: randomize input items: A, B, en
      A  = $random();
      B  = $random();
      #5ns;
      en = $urandom_range(1, 0);

      // Reference Model: computes expected result
      // expected_value_rfm = refmod(A, B); // eg function
      refmod(A, B, 0, expected_value_rfm); // eg task

      // drives+monitor DUT
      if(en) begin
        expected_value_rfm_lastvalue = A+B;
        @(posedge clk);
        @(posedge clk);
        out_dut = {carry_out, sum};
      end else begin
        @(posedge clk);
        @(posedge clk);
      end

      // scoreboard
      if(en) begin
        if(out_dut != unsigned'(expected_value_rfm)) begin
          $display("A was different of B");
          $display("%d + %d != %d", A, B, out_dut);
          $display("%d + %d != %d [rfm]",  A, B, expected_value_rfm);
          mismatch++;
        end else begin
          match++;
        end
      end else begin
        if(out_dut != unsigned'(expected_value_rfm_lastvalue)) begin
          $display("A was different of B");
          $display("%d + %d != %d", A, B, out_dut);
          $display("%d + %d != %d [rfm]",  A, B, expected_value_rfm);
          mismatch++;
        end else begin
          match++;
        end
      end

      // update trasaction counter
      tr++;
      if ((tr % STEP) == 0) begin
        pct    = (tr * 100) / NUM_OF_SEQS;
        filled = pct / 10;

        $write("PASS [");

        for (int i = 0; i < 10; i++) begin
          if (i < filled)
            $write("#");
          else
            $write("-");
        end

        $display("] %0d%%  (%0d/%0d)", pct, tr, NUM_OF_SEQS);
      end
    end

    // final report
    $display("\nTest finished / Final report:");
    $display("num of transactions = %0d", tr);
    $display("match               = %0d/%0d", match, tr);
    $display("mismatched          = %0d/%0d\n", mismatch, tr);

    $finish;
  end

  reg [8*200:1] fsdb_name;
  initial begin
    if (!$value$plusargs("FSDB=%s", fsdb_name))
      fsdb_name = "adder32.fsdb";

    $display("[TB] FSDB file = %0s", fsdb_name);
    $fsdbDumpfile(fsdb_name);
    $fsdbDumpvars();

    // #100ns;
    // $finish;
  end
endmodule
