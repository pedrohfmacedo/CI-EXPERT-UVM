//Function: The test bench applies random values to 3-bit select lines and checks the
//dout. The waveform mux8x1_tb.vcd can be observed using waveform viewer.
//Test bench file: mux8x1_tb.v


// Interface 
interface mux8x1_if (input logic clk);
    logic rstn;
    logic en;
    logic [2:0] sel;
    logic [7:0] din;
    logic dout;   
endinterface

//Top
module mux8x1_tb;

logic clk = 0;
logic dout;

// Instance of the interface
demux8x1_if demux_if (.clk(clk));

// Counter Scoreboard
int pass_count = 0;
int fail_count = 0;

// clock generation
always #5 clk = ~clk; // toggle clock for every 5 ticks

// Instance DUT
mux8x1 dut (
    .clk(mux8x1_if.clk)
    .rstn(mux8x1_if.rstn),
    .en(mux8x1_if.en),  // avtive high enable
    .din(mux8x1_if.sel), //data input
    .sel(mux8x1_if.din), // select lines
    .dout(mux8x1_if.dout) // data output
);
// Reference model
function logic reference_model(logic en, logic [2:0] sel, logic din[];)
endfunction

// Check function scores the results (Scoreboard)
function
        
endfunction
initial begin
    // Initialize Inputs
    clk = 0;
    rstn = 1;
    en = 0;

    //$display("--------- Test Started ---------");

    #10 rstn = 0;
    #10 rstn = 1;

    en = 1;

    sel = 3'b000; din = 8'b00000001;
    #10 sel = 3'b001; din = 8'b00000010;
    #10 sel = 3'b010; din = 8'b00000100;
    #10 sel = 3'b011; din = 8'b00001000;
    #10 sel = 3'b100; din = 8'b00010000;
    #10 sel = 3'b101; din = 8'b00100000;
    #10 sel = 3'b110; din = 8'b01000000;
    #10 sel = 3'b111; din = 8'b10000000;
    #10 sel = 3'b111; din = 8'b00000000;
    #10 sel = 3'b110; din = 8'b10000000;
    #10 sel = 3'b100; din = 8'b00010000;

    #100 $finish;
end

mux8x1 uut (
    .clk(clk),
    .rstn(rstn),
    .en(en),
    .din(din),
    .sel(sel),
    .dout(dout)
);

initial begin
    $fsdbDumpfile("demux1x8.fsdb");
    $fsdbDumpvars();
end

endmodule