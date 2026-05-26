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
// Atualziado de reguistradores
// Logica de saída
// ====================================================
// STATE DEFINITIONS
// ====================================================
typedef enum logic [3:0] {
   MAIN_WAIT_REQ,
   MAIN_S0_LOAD,
   MAIN_S0_UNLOAD,
   MAIN_S1_LOAD,
   MAIN_S1_UNLOAD,
   MAIN_S2_LOAD,
   MAIN_S2_UNLOAD,
   MAIN_S3_LOAD,
   MAIN_S3_UNLOAD
 } main_state_t;

 typedef enum logic [3:0] { 
   LOAD_IDLE,
   LOAD_START,
   LOAD_WRIST_HORIZONTAL,
   LOAD_ITEM_AND_CLOSE,
   LOAD_WRIST_VERTICAL
 } load_state_t;

 typedef enum logic [3:0] {
   UNLOAD_IDLE,
   UNLOAD_START,
   UNLOAD_TURN_A_RIGHT,
   UNLOAD_TURN_B_DOWN,
   UNLOAD_RELEASE_CLAW_E,
   UNLOAD_TURN_JOINTA_LEFT,
   UNLOAD_TURN_JOINTB_UP,
   UNLOAD_TURN_C_DOWN,
   UNLOAD_TURN_C_UP
} unload_state_t ;

// State registers
main_state_t   main_state,   main_next;
load_state_t   load_state,   load_next;
unload_state_t unload_state, unload_next;

// typedef enum logic [3:0] {
//       MAIN_CONTROL_IDLE, //wait_REQ

//       MAIN_CONTROL_LOAD,
//       LOAD_START,
//       LOAD_WRIST_HORIZONTAL,
//       LOAD_ITEM_AND_CLOSE,
//       LOAD_WRIST_VERTICAL,

//       MAIN_CONTROL_UNLOAD,
//       UNLOAD_START,
//       UNLOAD_TURN_A_RIGHT,
//       UNLOAD_TURN_B_DOWN,
//       UNLOAD_RELEASE_CLAW_E,
//       UNLOAD_TURN_JOINTA_LEFT,
//       UNLOAD_TURN_JOINTB_UP,
//       UNLOAD_TURN_C_DOWN,
//       UNLOAD_TURN_C_UP,
// }state_t;

// ====================================================
// LOGIC STATE REGISTER
// ====================================================

always @(posedge clock or negedge reset_n) begin
   if (!reset_n) begin
      main_state <= MAIN_WAIT_REQ;
      load_state <= LOAD_IDLE;
      unload_state <= UNLOAD_IDLE;
   end
   else begin
      main_state <= main_next;
      load_state <= load_next;
      unload_state <= unload_next;
   end
end

// ====================================================
// NEXT STATE LOGIC
// ====================================================

always_comb begin
    main_next = main_state;
    // lógica da main FSM
    case (main_state)
       MAIN_WAIT_REQ: begin
            if (s0_req && !s1_req && !s2_req && !s3_req)
                main_next = MAIN_S0_LOAD;
            else if (s1_req && !s0_req && !s2_req && !s3_req)
                main_next = MAIN_S1_LOAD;
            else if (s2_req && !s0_req && !s1_req && !s3_req)
                main_next = MAIN_S2_LOAD;
            else if (s3_req && !s0_req && !s1_req && !s2_req)
                main_next = MAIN_S3_LOAD;
            else 
                main_next = MAIN_WAIT_REQ;
        end

        MAIN_S0_LOAD:
            main_next = MAIN_S0_UNLOAD;

        MAIN_S0_UNLOAD: begin
            if (s0_done)
                main_next = MAIN_WAIT_REQ;
        end

        MAIN_S1_LOAD:
            main_next = MAIN_S1_UNLOAD;

        MAIN_S1_UNLOAD: begin
            if (s1_done)
                main_next = MAIN_WAIT_REQ;
        end

        MAIN_S2_LOAD:
            main_next = MAIN_S2_UNLOAD;

        MAIN_S2_UNLOAD: begin
            if (s2_done)
                main_next = MAIN_WAIT_REQ;
        end

        MAIN_S3_LOAD:
            main_next = MAIN_S3_UNLOAD;

        MAIN_S3_UNLOAD: begin
            if (s3_done)
                main_next = MAIN_WAIT_REQ;
        end

        MAIN_S2_LOAD:
            main_next = MAIN_S2_UNLOAD;

        MAIN_S2_UNLOAD: begin
            if (s2_done)
                main_next = MAIN_WAIT_REQ;
        end

        MAIN_S3_START:
            main_next = MAIN_S3_LOAD;

        MAIN_S3_LOAD:
            main_next = MAIN_S3_UNLOAD;

        MAIN_S3_UNLOAD: begin
            if (s3_done)
                main_next = MAIN_WAIT_REQ;
        end

        default:
            main_next = MAIN_WAIT_REQ;

    endcase
end

always_comb begin
    load_next = load_state;
    // lógica da load FSM
    case (load_state)
    
         LOAD_IDLE: begin
               if (state == S0_START || state == S1_START || state == S2_START || state == S3_START)
                  load_next = LOAD_START;
         end
   
         LOAD_START:
               load_next = LOAD_WRIST_HORIZONTAL;
               load_start = 1;

         LOAD_WRIST_HORIZONTAL:
               load_next = LOAD_ITEM_AND_CLOSE;
   
         LOAD_ITEM_AND_CLOSE:
               load_next = LOAD_WRIST_VERTICAL;
   
         LOAD_WRIST_VERTICAL:
               load_next = LOAD_IDLE;
   
         default:
               load_next = LOAD_IDLE;
    endcase 
end

logic is_s1_or_s3 = (state == S1_START || state == S3_START);
logic is_s0_or_s2 = (state == S0_START || state == S2_START);

always_comb begin
    unload_next = unload_state;
    // lógica da unload FSM
    case (unload_state)
    
         UNLOAD_IDLE: begin
               if (state == S0_START || state == S1_START || state == S2_START || state == S3_START)
                  unload_next = UNLOAD_START;
         end
   
         UNLOAD_START:
               unload_next = UNLOAD_TURN_A_RIGHT;
   
         UNLOAD_TURN_A_RIGHT:
               unload_next = TURN_B_DOWN;
   
         UNLOAD_TURN_B_DOWN:
            if (is_s1_or_s3)
               unload_next = TURN_C_DOWN;
            else
               unload_next = UNLOAD_RELEASE_CLAW;
   
         UNLOAD_RELEASE_CLAW_E:
            if (is_s1_or_s3)
               unload_next = TURN_C_UP;
            else
               unload_next = TURN_JOINTA_LEFT;
   
         UNLOAD_TURN_JOINTA_LEFT:
               unload_next = UNLOAD_TURN_JOINTB_UP;
   
         UNLOAD_TURN_C_DOWN:
               unload_next = RELEASE_CLAW_E;
   
         UNLOAD_TURN_C_UP:
               unload_next = UNLOAD_TURN_A_LEFT;
   
         UNLOAD_TURN_JOINTB_UP:
               if (s0_req)
                  s0_done = 1;
                  main_next = MAIN_WAIT_REQ;
               else if (s1_req)
                  s1_done = 1;
                  main_next = MAIN_WAIT_REQ;
               else if (s2_req)
                  s2_done = 1;
                  main_next = MAIN_WAIT_REQ;
               else if (s3_req)
                  s3_done = 1;
                  main_next = MAIN_WAIT_REQ;

         default:
               unload_next = UNLOAD_IDLE;
    endcase 
end

// Output generation
assign load_start = (load_cstate == LOAD_START);

wire unload_done; 
assign unload_done = s0_unload_done | s1_unload_done | s2_unload_done | s3_unload_done;

// ====================================================
// OUTPUT LOGIC
// ====================================================

// assign s0_unloadstart =( unload_cstate == JOINTA_RIGHT | RELEASE_CLAWE |JOINTA_LEFT);
assign s0_start = (unload_state == JOINTA_RIGHT | RELEASE_CLAWE |JOINTA_LEFT) ;
assign s1_start = (unload_state == JOINTA_RIGHT | RELEASE_CLAWE |JOINTA_LEFT);

// assign s1_unloadstart =( unload_cstate == JOINTA_RIGHT | JOINTC_DOWN |JOINTC_UP | RELEASE_CLAWE |JOINTA_LEFT) ;
assign s2_start = (unload_state == JOINTA_RIGHT | RELEASE_CLAWE |JOINTA_LEFT) ;
assign s3_start = (unload_state == JOINTA_RIGHT | JOINTC_DOWN |JOINTC_UP | RELEASE_CLAWE |JOINTA_LEFT) ;

endmodule
