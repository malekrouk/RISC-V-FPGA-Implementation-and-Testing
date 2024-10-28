`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 03:22:31 PM
// Design Name: 
// Module Name: n_bit_shift_left
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

module n_bit_shift_left #(parameter N=8)(input [N-1:0] x, output [N-1:0] y);
assign y = {x[N-2:0], 1'b0};

endmodule
