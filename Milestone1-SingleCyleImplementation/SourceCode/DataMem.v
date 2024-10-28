`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2024 02:30:35 PM
// Design Name: 
// Module Name: DataMem
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


module DataMem
(input clk, input MemRead, input MemWrite,
input [7:0] addr, input [31:0] data_in, input [2:0] funct3, output reg [31:0] data_out);
reg [7:0] mem [0:255]; //Byte addresable


always @(*) begin
case(funct3)
0: data_out = MemRead? {{24{mem[addr][7]}}, mem[addr]} : data_out; //lb
1: data_out = MemRead? {{16{mem[addr+1][7]}},mem[addr+1],mem[addr]} : data_out;  //lh
2: data_out = MemRead? {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]} : data_out;  //lw
4: data_out = MemRead? {24'b0, mem[addr]} : data_out; //lbu
5:data_out = MemRead? {16'b0, mem[addr+1], mem[addr]} : data_out; //lhu
endcase
end

always @(posedge clk)
begin
if(MemWrite)
begin
case(funct3)
0: mem[addr] = data_in[7:0]; //sb
1: begin //sh
mem[addr] = data_in[7:0];
mem[addr+1] = data_in[15:8];
end
2:begin //sw
mem[addr] = data_in[7:0];
mem[addr+1] = data_in[15:8];
mem[addr+2] = data_in[23:16];
mem[addr+3] = data_in[31:24];
end
endcase


end
end

endmodule

