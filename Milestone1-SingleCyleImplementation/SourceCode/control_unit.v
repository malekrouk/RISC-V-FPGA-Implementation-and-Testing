`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 04:01:02 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(input [4:0] inst, output reg branch, memRead, MemtoReg, output reg [1:0] ALUop, output reg memWrite, ALUsrc, regWrite);
always @(*)
begin
case(inst)
0: begin
branch = 1'b0;
memRead = 1'b1;
MemtoReg = 1'b1;
ALUop = 2'b00;
memWrite = 1'b0;
ALUsrc = 1'b1;
regWrite =1'b1;
end
  
4: begin
branch = 1'b0;
memRead = 1'b0;
MemtoReg = 1'b0;
ALUop = 2'b11;
memWrite = 1'b0;
ALUsrc = 1'b1;
regWrite =1'b1;
end

5: begin
branch = 1'b0;
memRead = 1'b0;
MemtoReg = 1'b0;
ALUop = 2'bXX;
memWrite = 1'b0;
ALUsrc = 1'bX;
regWrite =1'b1;
end

8:begin
branch = 1'b0;
memRead = 1'b0;
MemtoReg = 1'bX;
ALUop = 2'b00;
memWrite = 1'b1;
ALUsrc = 1'b1;
regWrite =1'b0;
end

12:begin
branch = 1'b0;
memRead = 1'b0;
MemtoReg = 1'b0;
ALUop = 2'b10;
memWrite = 1'b0;
ALUsrc = 1'b0;
regWrite =1'b1;
end

13: begin
branch = 1'b0;
memRead = 1'b0;
MemtoReg = 1'b0;
ALUop = 2'bXX;
memWrite = 1'b0;
ALUsrc = 1'bX;
regWrite =1'b1;
end

24:begin
branch = 1'b1;
memRead = 1'b0;
MemtoReg = 1'bX;
ALUop = 2'b01;
memWrite = 1'b0;
ALUsrc = 1'b0;
regWrite =1'b0;
end 

29:begin
branch = 1'b1;
memRead = 1'b0;
MemtoReg = 1'bX;
ALUop = 2'b00;
memWrite = 1'b0;
ALUsrc = 1'b1;
regWrite =1'b1;
end

25:begin
branch = 1'b1;
memRead = 1'b0;
MemtoReg = 1'bX;
ALUop = 2'b00;
memWrite = 1'b0;
ALUsrc = 1'b1;
regWrite =1'b1;
end

endcase
end
endmodule
