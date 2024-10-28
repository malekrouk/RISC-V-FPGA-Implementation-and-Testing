`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 02:06:17 PM
// Design Name: 
// Module Name: n_bit_register
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


module n_bit_register #(parameter N = 8)(input clk,rst, input [N-1:0] D,input load, en, output [N-1:0] Q
    );
    wire [N-1:0]out;
    genvar j;
    generate
    for(j=0;j<N;j=j+1)
    begin
    Mux2x1 mux(.a(D[j]),.b(Q[j]),.sel(load),.c(out[j]));
    DFlipFlop flop(.clk(clk),.rst(rst),.en(en),.D(out[j]),.Q(Q[j]));
     end  
  endgenerate
endmodule
