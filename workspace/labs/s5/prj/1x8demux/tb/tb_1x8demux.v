//Function: The test bench applies random values to 3-bit select lines and checks the
//dout. The waveform demux_tb.vcd can be observed using waveform viewer.
//Test bench file: demux3x8_tb.v

module demux1x8_tb;


// Interface 
interface demux1x8_if (input logic clk);
    logic rstn;
    logic en;
    logic [2:0] sel;
    logic din;
    logic [7:0] dout;   
endinterface
// Inputs
reg clk;
reg rstn;
reg en;
reg [2:0] sel;
reg din;

// Outputs
wire [7:0] dout;

// clock generation
always #5 clk = ~clk; // toggle clock for every 5 ticks

initial begin
    clk = 0;
    rstn = 0;
    en = 0;

    //$display("--------- Test Started ---------");

    #10 rstn = 0;
    #10 rstn = 1;

    en = 1;

    sel = 3'b000; din = 1'b1;
    #10 sel = 3'b001; din = 1'b1;
    #10 sel = 3'b010; din = 1'b1;
    #10 sel = 3'b011; din = 1'b1;
    #10 sel = 3'b100; din = 1'b1;
    #10 sel = 3'b101; din = 1'b1;
    #10 sel = 3'b110; din = 1'b1;
    #10 sel = 3'b111; din = 1'b1;

    #100 $finish;
end

demux1x8 uut (
    .clk(clk),
    .rstn(rstn),
    .en(en),
    .sel(sel),
    .din(din),
    .dout(dout)
);

initial begin
    $fsdbDumpfile("demux1x8.fsdb");
    $fsdbDumpvars();
end
endmodule