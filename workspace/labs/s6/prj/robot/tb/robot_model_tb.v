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

   // individual request generation (no req)
   s0_req = 1'b1;
   #100;
   s0_req = 1'b0;
   s1_req = 1'b0;
   s2_req = 1'b0;
   s3_req = 1'b0;
   
   #100;
   // all done?
   s0_unload_done = 1'b0;
   s1_unload_done = 1'b0;
   s2_unload_done = 1'b0;
   s3_unload_done = 1'b0;

   #500;


   // #15;
   // s0_req = 1'b1;
   // #15;
   // s0_req = 1'b0;
   // #50;
   // s1_req = 1'b1;
   // #50;
   // s1_req = 1'b0;
       
   // s2_req = 1'b1;
   // #50;
   // s2_req = 1'b0;
   // s3_req = 1'b1;
   // #50;
   // s3_req = 1'b0;
end

initial begin
   $fsdbDumpfile("robot.fsdb");
   $fsdbDumpvars(2,robot_model_tb);  
   #300;
   $finish;
end

endmodule
