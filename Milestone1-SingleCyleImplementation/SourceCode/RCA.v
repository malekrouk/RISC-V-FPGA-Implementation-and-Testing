`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 02:14:34 PM
// Design Name: 
// Module Name: RCA
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


module RCA #(parameter N=8)(input [N-1:0] a,input [N-1:0] b, output [N-1:0] sum, output cout);

genvar j;
wire [N:0] carry;
assign carry[0]=1'b0;
generate
for(j = 0; j < N; j = j+1)
begin: Gen_Modules
FA adders(.a(a[j]), .b(b[j]), .cin(carry[j]), .cout(carry[j+1]), .sum(sum[j]));
end
endgenerate
assign cout = carry[N];
endmodule
