module robot_model(
   input  logic clock,
   input  logic reset_n,

   // Sensor requests for unloading.
   input  logic s0_req,
   input  logic s1_req,
   input  logic s2_req,
   input  logic s3_req,

   // Station unload start.
   output logic s0_unloadstart,
   output logic s1_unloadstart,
   output logic s2_unloadstart,
   output logic s3_unloadstart,

   // Station unload done.
   input  logic s0_unload_done,
   input  logic s1_unload_done,
   input  logic s2_unload_done,
   input  logic s3_unload_done,

   // Robot load start.
   output logic load_start
);

// ====================================================
// STATE DEFINITIONS
// ====================================================
typedef enum logic [1:0] {
   MAIN_WAIT_REQ = 2'd0,
   MAIN_S0_S1    = 2'd1,
   MAIN_S2_S3    = 2'd2
} main_state_t;

typedef enum logic [1:0] {
   LOAD_IDLE       = 2'd0,
   LOAD_WRIST_HOR  = 2'd1,
   LOAD_ITEM       = 2'd2,
   LOAD_WRIST_VERT = 2'd3
} load_state_t;

typedef enum logic [2:0] {
   UNLOAD_IDLE         = 3'd0,
   UNLOAD_JOINTA_RIGHT = 3'd1,
   UNLOAD_JOINTC_DOWN  = 3'd2,
   UNLOAD_JOINTC_UP    = 3'd3,
   UNLOAD_RELEASE_CLAW = 3'd4,
   UNLOAD_JOINTA_LEFT  = 3'd6
} unload_state_t;

main_state_t   curr_state, next_state;
load_state_t   load_cstate, load_nstate;
unload_state_t unload_cstate, unload_nstate;

logic [1:0] station, next_station;
logic       station_valid, next_station_valid;

logic [3:0] req_vec;
logic [3:0] done_vec;
logic       onehot_req;
logic       station_needs_joint_c;
logic       station_done;

assign req_vec  = {s3_req, s2_req, s1_req, s0_req};
assign done_vec = {s3_unload_done, s2_unload_done, s1_unload_done, s0_unload_done};

assign onehot_req = (req_vec == 4'b0001) ||
                    (req_vec == 4'b0010) ||
                    (req_vec == 4'b0100) ||
                    (req_vec == 4'b1000);

assign station_needs_joint_c = station_valid &&
                               ((station == 2'd1) || (station == 2'd3));
assign station_done = station_valid && done_vec[station];

// ====================================================
// STATE REGISTERS
// ====================================================
always_ff @(posedge clock or negedge reset_n) begin
   if (!reset_n) begin
      curr_state    <= MAIN_WAIT_REQ;
      load_cstate   <= LOAD_IDLE;
      unload_cstate <= UNLOAD_IDLE;
      station       <= 2'd0;
      station_valid <= 1'b0;
   end
   else begin
      curr_state    <= next_state;
      load_cstate   <= load_nstate;
      unload_cstate <= unload_nstate;
      station       <= next_station;
      station_valid <= next_station_valid;
   end
end

// ====================================================
// SERVED STATION TRACKING
// ====================================================
always_comb begin
   next_station       = station;
   next_station_valid = station_valid;

   if (!station_valid && onehot_req) begin
      unique case (req_vec)
         4'b0001: next_station = 2'd0;
         4'b0010: next_station = 2'd1;
         4'b0100: next_station = 2'd2;
         4'b1000: next_station = 2'd3;
         default: next_station = 2'd0;
      endcase

      next_station_valid = 1'b1;
   end

   if (unload_cstate == UNLOAD_JOINTA_LEFT) begin
      next_station       = 2'd0;
      next_station_valid = 1'b0;
   end
end

// ====================================================
// MAIN CONTROL STATE MACHINE
// ====================================================
always_comb begin
   next_state = curr_state;

   unique case (curr_state)
      MAIN_WAIT_REQ: begin
         if (onehot_req && (s0_req || s1_req))
            next_state = MAIN_S0_S1;
         else if (onehot_req && (s2_req || s3_req))
            next_state = MAIN_S2_S3;
         else
            next_state = MAIN_WAIT_REQ;
      end

      MAIN_S0_S1,
      MAIN_S2_S3: begin
         if (station_done)
            next_state = MAIN_WAIT_REQ;
      end

      default:
         next_state = MAIN_WAIT_REQ;
   endcase
end

// ====================================================
// LOAD STATE MACHINE
// ====================================================
always_comb begin
   load_nstate = load_cstate;

   unique case (load_cstate)
      LOAD_IDLE: begin
         if (!station_valid && onehot_req)
            load_nstate = LOAD_WRIST_HOR;
         else
            load_nstate = LOAD_IDLE;
      end

      LOAD_WRIST_HOR:
         load_nstate = LOAD_ITEM;

      LOAD_ITEM:
         load_nstate = LOAD_WRIST_VERT;

      LOAD_WRIST_VERT:
         load_nstate = LOAD_IDLE;

      default:
         load_nstate = LOAD_IDLE;
   endcase
end

// ====================================================
// UNLOAD STATE MACHINE
// ====================================================
always_comb begin
   unload_nstate = unload_cstate;

   unique case (unload_cstate)
      UNLOAD_IDLE: begin
         if (load_cstate == LOAD_WRIST_VERT)
            unload_nstate = UNLOAD_JOINTA_RIGHT;
         else
            unload_nstate = UNLOAD_IDLE;
      end

      UNLOAD_JOINTA_RIGHT: begin
         if (station_needs_joint_c)
            unload_nstate = UNLOAD_JOINTC_DOWN;
         else
            unload_nstate = UNLOAD_RELEASE_CLAW;
      end

      UNLOAD_JOINTC_DOWN:
         unload_nstate = UNLOAD_RELEASE_CLAW;

      UNLOAD_RELEASE_CLAW: begin
         if (station_needs_joint_c)
            unload_nstate = UNLOAD_JOINTC_UP;
         else if (station_done)
            unload_nstate = UNLOAD_JOINTA_LEFT;
      end

      UNLOAD_JOINTC_UP: begin
         if (station_done)
            unload_nstate = UNLOAD_JOINTA_LEFT;
      end

      UNLOAD_JOINTA_LEFT:
         unload_nstate = UNLOAD_IDLE;

      default:
         unload_nstate = UNLOAD_IDLE;
   endcase
end

// ====================================================
// OUTPUT GENERATION
// ====================================================
assign load_start = (load_cstate == LOAD_WRIST_HOR);

assign s0_unloadstart = station_valid && (station == 2'd0) &&
                        ((load_cstate == LOAD_WRIST_VERT) || (unload_cstate != UNLOAD_IDLE));
assign s1_unloadstart = station_valid && (station == 2'd1) &&
                        ((load_cstate == LOAD_WRIST_VERT) || (unload_cstate != UNLOAD_IDLE));
assign s2_unloadstart = station_valid && (station == 2'd2) &&
                        ((load_cstate == LOAD_WRIST_VERT) || (unload_cstate != UNLOAD_IDLE));
assign s3_unloadstart = station_valid && (station == 2'd3) &&
                        ((load_cstate == LOAD_WRIST_VERT) || (unload_cstate != UNLOAD_IDLE));

endmodule
