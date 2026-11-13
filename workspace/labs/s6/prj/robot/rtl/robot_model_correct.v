module robot_model(
   clock,
   reset_n,
   s0_req,
   s1_req,
   s2_req,
   s3_req,

   s0_unloadstart,
   s1_unloadstart,
   s2_unloadstart,
   s3_unloadstart,

   s0_unload_done,
   s1_unload_done,
   s2_unload_done,
   s3_unload_done,

   load_start
);

input clock, reset_n;

// Sensor request. The corrected design accepts only one-hot requests, matching
// the testbench reference model and the project assumption of one request at a time.
input s0_req;
input s1_req;
input s2_req;
input s3_req;

// Station unload start.
output s0_unloadstart;
output s1_unloadstart;
output s2_unloadstart;
output s3_unloadstart;

// Station unload done.
input s0_unload_done;
input s1_unload_done;
input s2_unload_done;
input s3_unload_done;

// Robot load start.
output load_start;

reg [1:0] curr_state, next_state;
reg [1:0] load_cstate, load_nstate;

// FIX: unload_cstate/unload_nstate are 3 bits. The original RTL declared them
// as 2 bits, truncating RELEASE_CLAW=100 and JOINTA_LEFT=110.
reg [2:0] unload_cstate, unload_nstate;

// FIX: latch the station being served. This lets the design ignore request
// changes during operation and accept only the matching unload_done.
reg [1:0] station, next_station;
reg       station_valid, next_station_valid;

parameter IDLE       = 2'b00;
parameter WRIST_HOR  = 2'b01;
parameter LOAD_ITEM  = 2'b10;
parameter WRIST_VERT = 2'b11;

parameter MAIN_WAIT_REQ = 2'b00;
parameter MAIN_S0_S1    = 2'b01;
parameter MAIN_S2_S3    = 2'b10;

parameter JOINTA_RIGHT  = 3'b001;
parameter JOINTC_DOWN   = 3'b010;
parameter JOINTC_UP     = 3'b011;
parameter RELEASE_CLAW  = 3'b100;
parameter JOINTA_LEFT   = 3'b110;

wire [3:0] req_vec;
wire [3:0] done_vec;
wire       onehot_req;
wire       station_needs_joint_c;
wire       station_done;

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
always @(posedge clock or negedge reset_n) begin
   if (!reset_n) begin
      curr_state       <= MAIN_WAIT_REQ;
      load_cstate      <= IDLE;
      unload_cstate    <= IDLE;
      station          <= 2'd0;
      station_valid    <= 1'b0;
   end
   else begin
      curr_state       <= next_state;
      load_cstate      <= load_nstate;
      unload_cstate    <= unload_nstate;
      station          <= next_station;
      station_valid    <= next_station_valid;
   end
end

// ====================================================
// SERVED STATION TRACKING
// ====================================================
always @(*) begin
   next_station       = station;
   next_station_valid = station_valid;

   // FIX: capture only valid one-hot requests while the robot is idle. This
   // makes 1111, 1010, and other multi-request patterns ignored by design.
   if (!station_valid && onehot_req) begin
      case (req_vec)
         4'b0001: next_station = 2'd0;
         4'b0010: next_station = 2'd1;
         4'b0100: next_station = 2'd2;
         4'b1000: next_station = 2'd3;
         default: next_station = 2'd0;
      endcase
      next_station_valid = 1'b1;
   end

   // FIX: release the latched station only after the final unload state.
   if (unload_cstate == JOINTA_LEFT) begin
      next_station       = 2'd0;
      next_station_valid = 1'b0;
   end
end

// ====================================================
// MAIN CONTROL STATE MACHINE
// ====================================================
always @(*) begin
   next_state = curr_state;

   if (!reset_n) begin
      next_state = MAIN_WAIT_REQ;
   end
   else begin
      case (curr_state)
         MAIN_WAIT_REQ: begin
            // FIX: only one-hot requests are legal. Multi-request patterns stay idle.
            if (onehot_req && (s0_req || s1_req))
               next_state = MAIN_S0_S1;
            else if (onehot_req && (s2_req || s3_req))
               next_state = MAIN_S2_S3;
            else
               next_state = MAIN_WAIT_REQ;
         end

         MAIN_S0_S1,
         MAIN_S2_S3: begin
            // FIX: ignore wrong done bits; return to WAIT_REQ only for the
            // station currently being served.
            if (station_done)
               next_state = MAIN_WAIT_REQ;
         end

         default:
            next_state = MAIN_WAIT_REQ;
      endcase
   end
end

// ====================================================
// LOAD STATE MACHINE
// ====================================================
always @(*) begin
   load_nstate = load_cstate;

   if (!reset_n) begin
      load_nstate = IDLE;
   end
   else begin
      case (load_cstate)
         IDLE: begin
            if (!station_valid && onehot_req)
               load_nstate = WRIST_HOR;
            else
               load_nstate = IDLE;
         end

         WRIST_HOR:
            load_nstate = LOAD_ITEM;

         LOAD_ITEM:
            load_nstate = WRIST_VERT;

         WRIST_VERT:
            load_nstate = IDLE;

         default:
            load_nstate = IDLE;
      endcase
   end
end

// ====================================================
// UNLOAD STATE MACHINE
// ====================================================
always @(*) begin
   unload_nstate = unload_cstate;

   if (!reset_n) begin
      unload_nstate = IDLE;
   end
   else begin
      case (unload_cstate)
         IDLE: begin
            // FIX: unload starts only after the load sequence reaches WRIST_VERT.
            if (load_cstate == WRIST_VERT)
               unload_nstate = JOINTA_RIGHT;
            else
               unload_nstate = IDLE;
         end

         JOINTA_RIGHT: begin
            if (station_needs_joint_c)
               unload_nstate = JOINTC_DOWN;
            else
               unload_nstate = RELEASE_CLAW;
         end

         JOINTC_DOWN:
            unload_nstate = RELEASE_CLAW;

         RELEASE_CLAW: begin
            if (station_needs_joint_c)
               unload_nstate = JOINTC_UP;
            else if (station_done)
               unload_nstate = JOINTA_LEFT;
         end

         JOINTC_UP: begin
            if (station_done)
               unload_nstate = JOINTA_LEFT;
         end

         JOINTA_LEFT:
            unload_nstate = IDLE;

         default:
            unload_nstate = IDLE;
      endcase
   end
end

// ====================================================
// OUTPUT GENERATION
// ====================================================
assign load_start = (load_cstate == WRIST_HOR);

// FIX: unloadstart is asserted only for the station being served. It remains
// high from WRIST_VERT through the unload sequence until JOINTA_LEFT, ignoring other requests and done bits.
assign s0_unloadstart = station_valid && (station == 2'd0) &&
                        ((load_cstate == WRIST_VERT) || (unload_cstate != IDLE));
assign s1_unloadstart = station_valid && (station == 2'd1) &&
                        ((load_cstate == WRIST_VERT) || (unload_cstate != IDLE));
assign s2_unloadstart = station_valid && (station == 2'd2) &&
                        ((load_cstate == WRIST_VERT) || (unload_cstate != IDLE));
assign s3_unloadstart = station_valid && (station == 2'd3) &&
                        ((load_cstate == WRIST_VERT) || (unload_cstate != IDLE));

endmodule
