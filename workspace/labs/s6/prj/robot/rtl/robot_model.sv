
module robot_model(

      input logic clock,
      input logic reset_n,

      // Request for unloading
      input logic s0_req,
      input logic s1_req,
      input logic s2_req,
      input logic s3_req,

      // Start loading
      output logic load_start,

      // Conclusion loading (done)
      input logic load_done,

      // Initiate unloading for station 
      output logic s0_start,
      output logic s1_start,
      output logic s2_start,
      output logic s3_start,
      
      // Conclusion unloading (done)
      input logic s0_done,
      input logic s1_done,
      input logic s2_done,
      input logic s3_done
   
);
// Logica de proxima estado 
//Atualziado de reguistradores
//logica de saída

// typedef enum logic [1:0] {
//       MAIN_CONTROL_IDLE, //wait_REQ
//       MAIN_CONTROL_LOAD,
//       MAINT_CONTROL_UNLOAD
// } main_state_t main_state;

// typedef enum logic [2:0] { 
//       LOAD_START,
//       LOAD_WRIST_HORIZONTAL,
//       LOAD_ITEM_AND_CLOSE,
//       LOAD_WRIST_VERTICAL
// } load_state_t load_state;

// typedef enum logic [3:0] {
//     UNLOAD_START,
//     UNLOAD_TURN_A_RIGHT,
//     UNLOAD_TURN_B_DOWN,
//     UNLOAD_RELEASE_CLAW_E,
//     UNLOAD_TURN_JOINTA_LEFT,
//     UNLOAD_TURN_JOINTB_UP,
//     UNLOAD_TURN_C_DOWN,
//     UNLOAD_TURN_C_UP
// } unload_state_t unload_state;

typedef enum logic [3:0] {
      MAIN_CONTROL_IDLE, //wait_REQ

      MAIN_CONTROL_LOAD,
      LOAD_START,
      LOAD_WRIST_HORIZONTAL,
      LOAD_ITEM_AND_CLOSE,
      LOAD_WRIST_VERTICAL,

      MAIN_CONTROL_UNLOAD,
      UNLOAD_START,
      UNLOAD_TURN_A_RIGHT,
      UNLOAD_TURN_B_DOWN,
      UNLOAD_RELEASE_CLAW_E,
      UNLOAD_TURN_JOINTA_LEFT,
      UNLOAD_TURN_JOINTB_UP,
      UNLOAD_TURN_C_DOWN,
      UNLOAD_TURN_C_UP,
}state_t;

state_t state;
state_t next_state;

// ====================================================
// LOGIC STATE REGISTER
// ====================================================
always_comb begin

    // permanece no estado atual por padrão
    next_state = state;

    case (state)
   
        //----------------------------------
        MAIN_CONTROL_IDLE:
        //----------------------------------
            if (start)
                next_state = LOAD_1;

        //----------------------------------
        LOAD_1:
        //----------------------------------
            if (load1_done)
                next_state = LOAD_2;

        //----------------------------------
        LOAD_2:
        //----------------------------------
            if (load2_done)
                next_state = LOAD_3;

        //----------------------------------
        LOAD_3:
        //----------------------------------
            if (load3_done)
                next_state = UNLOAD_1;

        //----------------------------------
        UNLOAD_1:
        //----------------------------------
            if (unload1_done)
                next_state = UNLOAD_2;

        //----------------------------------
        UNLOAD_2:
        //----------------------------------
            if (sensor_ok)
                next_state = UNLOAD_A;
            else
                next_state = UNLOAD_B;

        //----------------------------------
        UNLOAD_A:
        //----------------------------------
            if (path_a_done)
                next_state = UNLOAD_DONE;

        //----------------------------------
        UNLOAD_B:
        //----------------------------------
            if (path_b_done)
                next_state = UNLOAD_DONE;

        //----------------------------------
        UNLOAD_DONE:
        //----------------------------------
            next_state = DONE;

        //----------------------------------
        DONE:
        //----------------------------------
            next_state = IDLE;

        //----------------------------------
        default:
        //----------------------------------
            next_state = IDLE;

    endcase

end

always @(posedge clock or negedge reset_n) begin
   if (!reset_n) begin
      state    <= MAIN_CONTROL_IDLE.
   end
   else begin
      state <= next_state;
   end
end

// ====================================================
// NEXT STATE LOGIC
// ====================================================



wire unload_done; 
assign unload_done = s0_unload_done | s1_unload_done | s2_unload_done | s3_unload_done;

always @(reset_n or curr_state or unload_done or s0_req or s1_req or s2_req or s3_req) begin
   if (~reset_n)begin
      next_state <= 2'b00;
   end else begin
      case (curr_state )
         IDLE: begin
            if (s0_req || s1_req)
               next_state <= 2'b01;
            else if (s2_req || s3_req)
               next_state <= 2'b10;
            else
               next_state <= IDLE;  
         end
         
         2'b01: begin
            if (unload_done)
               next_state <= IDLE;
         end
         
         2'b10: begin
            if (unload_done)
               next_state <= IDLE;
         end
   
         default: next_state <= IDLE; 
      endcase
   end
end

wire s0ors2_req, s1ors3_req;

// output generation
wire s0_unloadstart;
wire s1_unloadstart;
wire s2_unloadstart;
wire s3_unloadstart;

assign s0ors2_req = s0_req | s2_req;
assign s1ors3_req = s1_req | s3_req; 

// ====================================================
// UNLOAD STATE MACHINE 
// ====================================================// load state machine
always @(reset_n or load_cstate or s0ors2_req or load_done_int or s1ors3_req) begin
   if (~reset_n)
      load_nstate <= IDLE;
   else begin
      case (load_cstate )
         IDLE: begin
            if (s0ors2_req || s1ors3_req)
               load_nstate <= WRIST_HOR;
            else
               load_nstate <= IDLE;  
         end

         WRIST_HOR : load_nstate <= LOAD_ITEM;
         LOAD_ITEM : load_nstate <= WRIST_VERT;
         WRIST_VERT: load_nstate <= IDLE; 
      endcase
   end
end

// output generation
assign load_start = (load_cstate == WRIST_HOR);

// ====================================================
// UNLOAD STATE MACHINE 
// ====================================================

// unload state machine
parameter JOINTA_RIGHT = 3'b001;
parameter JOINTC_DOWN = 3'b010;
parameter JOINTC_UP = 3'b011;
parameter RELEASE_CLAWE = 3'b100;
parameter JOINTA_LEFT = 3'b110;

always @(reset_n or unload_cstate or s0ors2_req or s1ors3_req or s0_unload_done or s1_unload_done or s2_unload_done or s3_unload_done) begin
   if (~reset_n)
      unload_nstate <= IDLE;
   else begin
      case (unload_cstate)
         IDLE: begin
            if(s0ors2_req || s1ors3_req)
               unload_nstate <= JOINTA_RIGHT;
            else
               unload_nstate <= IDLE;  
         end

         JOINTA_RIGHT: begin
            if (s1ors3_req)
               unload_nstate <= JOINTC_DOWN;
            else
               unload_nstate <= RELEASE_CLAWE;
         end

         JOINTC_DOWN: unload_nstate <= RELEASE_CLAWE;
         JOINTA_LEFT: unload_nstate <= IDLE;

         RELEASE_CLAWE: begin
            if (s1ors3_req)
               unload_nstate<= JOINTC_UP;
            else if(s0_unload_done | s2_unload_done)
               unload_nstate<= JOINTA_LEFT;
         end

         JOINTC_UP: begin
            if (s1_unload_done | s3_unload_done)
               unload_nstate<= JOINTA_LEFT;
         end
         
         default: unload_nstate<= IDLE;
      endcase
   end
end

// Output generation

// assign s0_unloadstart =( unload_cstate == JOINTA_RIGHT | RELEASE_CLAWE |JOINTA_LEFT);
assign s0_unloadstart = load_done_int;
assign s1_unloadstart = load_done_int
;
// assign s1_unloadstart =( unload_cstate == JOINTA_RIGHT | JOINTC_DOWN |JOINTC_UP | RELEASE_CLAWE |JOINTA_LEFT) ;
assign s2_unloadstart = (unload_cstate == JOINTA_RIGHT | RELEASE_CLAWE |JOINTA_LEFT) ;
assign s3_unloadstart = (unload_cstate == JOINTA_RIGHT | JOINTC_DOWN |JOINTC_UP | RELEASE_CLAWE |JOINTA_LEFT) ;

endmodule
