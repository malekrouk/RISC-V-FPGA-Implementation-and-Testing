`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 02:31:45 PM
// Design Name: 
// Module Name: Full_DP_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Full_DP_tb();
reg clk;
reg rst;
reg ssdCLK;
reg [1:0] ledSel;
reg [3:0]ssdSel;
wire [15:0] leds;
wire [3:0] Anode;
wire [6:0] LED_out;


Full_DP tb(.clk_IN(clk),.rst(rst),.ssdCLK(ssdCLK),.ledSel(ledSel),.ssdSel(ssdSel),.leds(leds) ,.Anode(Anode),
.LED_out(LED_out));
localparam period=10;
initial begin 
clk=0;
forever  
#(period/2)
clk = ~clk;
end


initial begin
rst=1'b1;
#period;
rst=1'b0;
ledSel=2'b01;
#(period*65);
$finish;
end


endmodule
