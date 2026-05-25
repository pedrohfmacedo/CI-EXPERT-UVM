/*************************************************************************

Testbench for ROBOT Design
Moore machine Design with Two process Blocks.

*************************************************************************/

module robot_model_tb;

reg clock;
reg reset_n;

//clock generation
initial  begin
   clock = 1'b0;
   forever #10 clock = ~clock;
end

// reset_n generation
initial begin
   #0 reset_n = 1'b1;
   #2 reset_n = 1'b0;
   #5 reset_n = 1'b1;
end

reg  s0_req, s1_req,s2_req,s3_req;
wire s0_unloadstart,s1_unloadstart,s2_unloadstart,s3_unloadstart;
reg  s0_unload_done, s1_unload_done,s2_unload_done,s3_unload_done=1'b0;
wire load_start;
// reg load_done;

task clear_manual_inputs;
   begin
      s0_req = 1'b0;
      s1_req = 1'b0;
      s2_req = 1'b0;
      s3_req = 1'b0;

      s0_unload_done = 1'b0;
      s1_unload_done = 1'b0;
      s2_unload_done = 1'b0;
      s3_unload_done = 1'b0;
   end
endtask

task run_manual_req;
   input [3:0] req_vec; // {s3_req, s2_req, s1_req, s0_req}
   input [8*32-1:0] case_name;
   begin
      $display("\n--- Manual test: %0s req[3:0]=%b ---", case_name, req_vec);

      {s3_req, s2_req, s1_req, s0_req} = req_vec;

      // Keep the request stable long enough for the RTL load/unload FSMs to
      // leave IDLE and walk through a full command cycle.
      repeat (8) @(posedge clock);

      {s3_unload_done, s2_unload_done, s1_unload_done, s0_unload_done} = req_vec;
      @(posedge clock);
      {s3_unload_done, s2_unload_done, s1_unload_done, s0_unload_done} = 4'b0000;

      {s3_req, s2_req, s1_req, s0_req} = 4'b0000;
      repeat (4) @(posedge clock);
   end
endtask

// module instantiation
robot_model u_robot_model(
   .clock           (clock  ),
   .reset_n         (reset_n),  

   .s0_req          (s0_req ),
   .s1_req          (s1_req ),
   .s2_req          (s2_req ),
   .s3_req          (s3_req ),

   .s0_unloadstart  (s0_unloadstart), 
   .s1_unloadstart  (s1_unloadstart), 
   .s2_unloadstart  (s2_unloadstart), 
   .s3_unloadstart  (s3_unloadstart), 

   .s0_unload_done  (s0_unload_done),
   .s1_unload_done  (s1_unload_done),
   .s2_unload_done  (s2_unload_done),
   .s3_unload_done  (s3_unload_done),

   .load_start      (load_start    )
);


// generate station unload requests
initial begin

   $display("State encoding: IDLE=00, WRIST_HOR=01, LOAD_ITEM=10, WRIST_VERT=11");
   $display("Unload encoding: IDLE=00, JOINTA_RIGHT=001, JOINTC_DOWN=010, JOINTC_UP=011, RELEASE_CLAWE=100, JOINTA_LEFT=110\n");
   $display("--------------------------------------------------------------------------------------------------------------");
   $display("   TIME    rst req[3:0] unload_done[3:0] | load_start unloadstart[3:0] | curr next load_cs load_ns unload_cs unload_ns");
   $display("--------------------------------------------------------------------------------------------------------------");
   $monitor("%t  %b    %b%b%b%b        %b%b%b%b        |     %b          %b%b%b%b        |   %b   %b     %b      %b       %b        %b",
            $time, reset_n,
            s3_req, s2_req, s1_req, s0_req,
            s3_unload_done, s2_unload_done, s1_unload_done, s0_unload_done,
            load_start,
            s3_unloadstart, s2_unloadstart, s1_unloadstart, s0_unloadstart,
            u_robot_model.curr_state,
            u_robot_model.next_state,
            u_robot_model.load_cstate,
            u_robot_model.load_nstate,
            u_robot_model.unload_cstate,
            u_robot_model.unload_nstate);

   clear_manual_inputs;

   @(posedge reset_n);
   repeat (2) @(posedge clock);

   // Basic manual sequence. req[3:0] is printed as {s3,s2,s1,s0}.
   run_manual_req(4'b0001, "s0 only");
   run_manual_req(4'b0010, "s1 only");
   run_manual_req(4'b0100, "s2 only");
   run_manual_req(4'b1000, "s3 only");

   // Stress/break cases with simultaneous requests.
   run_manual_req(4'b1111, "all stations");
   run_manual_req(4'b1010, "s3 and s1");

   #100;
   $finish;
end

initial begin
   $fsdbDumpfile("robot.fsdb");
   $fsdbDumpvars(2,robot_model_tb);  
end

endmodule
