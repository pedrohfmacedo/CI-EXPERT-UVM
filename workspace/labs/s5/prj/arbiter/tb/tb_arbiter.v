//==============================================================================
// File: arbiter_tb.v
// Description:
//   Simple testbench for the arbiter.
//   Applies requests from client1 and client2 and observes grants.
//==============================================================================

module arbiter_tb;

  // Inputs
  reg clk;
  reg reset_n;
  reg priority_sel;
  reg client1_req;
  reg client2_req;

  // Outputs
  wire o_grant1;
  wire o_grant2;

  //--------------------------------------------------------------------------
  // Clock generation
  //--------------------------------------------------------------------------
  initial begin
      clk = 1'b0;
      forever #5 clk = ~clk;
  end

  //--------------------------------------------------------------------------
  // DUT instantiation
  //--------------------------------------------------------------------------
  arbiter uu_arbiter (
      .clk         (clk),
      .reset_n     (reset_n),
      .priority_sel(priority_sel),
      .client1_req (client1_req),
      .client2_req (client2_req),
      .o_grant1    (o_grant1),
      .o_grant2    (o_grant2)
  );

  //--------------------------------------------------------------------------
  // Stimulus
  //--------------------------------------------------------------------------
  initial begin
      reset_n      = 1'b0;
      priority_sel = 1'b0;
      client1_req  = 1'b0;
      client2_req  = 1'b0;

      $display("========================================");
      $display("  Arbiter Testbench Started");
      $display("========================================");
      $display("Time: %0t | Initializing...", $time);

      // Reset
      #10 reset_n = 1'b0;
      #10 reset_n = 1'b1;
      $display("Time: %0t | Reset complete", $time);

      // Case 1: client1 has priority
      @(posedge clk);
      #1;
      $display("\n--- Test Case 1: Client1 Priority Mode ---");
      priority_sel = 1'b1;
      client1_req  = 1'b1;
      client2_req  = 1'b0;
      $display("Time: %0t | priority_sel=1, client1_req=1, client2_req=0", $time);

      #10;
      $display("Time: %0t | Switching: client1_req=0, client2_req=1", $time);
      client1_req  = 1'b0;
      client2_req  = 1'b1;

      #10;
      $display("Time: %0t | Both requests cleared", $time);
      client1_req  = 1'b0;
      client2_req  = 1'b0;

      // Case 2: both request, client2 has priority
      #10;
      $display("\n--- Test Case 2: Client2 Priority (Both Requesting) ---");
      priority_sel = 1'b0;
      client1_req  = 1'b1;
      client2_req  = 1'b1;
      $display("Time: %0t | priority_sel=0, client1_req=1, client2_req=1", $time);

      // Case 3: both request, client1 has priority
      #10;
      $display("\n--- Test Case 3: Client1 Priority (Both Requesting) ---");
      priority_sel = 1'b1;
      client1_req  = 1'b1;
      client2_req  = 1'b1;
      $display("Time: %0t | priority_sel=1, client1_req=1, client2_req=1", $time);

      #100 begin
          $display("\n========================================");
          $display("  Arbiter Testbench Finished");
          $display("========================================");
          $finish;
      end
  end

  //--------------------------------------------------------------------------
  // Monitors
  //--------------------------------------------------------------------------
  initial begin
      $display("\n--- Signal Monitor Started ---");
      forever begin
          @(posedge clk);
          $display("Time: %0t | CLK | priority_sel=%b | req1=%b req2=%b | grant1=%b grant2=%b",
                   $time, priority_sel, client1_req, client2_req, o_grant1, o_grant2);
      end
  end

  initial begin
      forever begin
          @(o_grant1 or o_grant2);
          $display("Time: %0t | **GRANT CHANGE** | o_grant1=%b o_grant2=%b", $time, o_grant1, o_grant2);
      end
  end

  //--------------------------------------------------------------------------
  // Dump
  //--------------------------------------------------------------------------
  initial begin
    $fsdbDumpfile("arbiter.fsdb");
    $fsdbDumpvars();
  end

endmodule