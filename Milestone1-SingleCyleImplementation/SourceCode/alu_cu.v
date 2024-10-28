`timescale 1ns / 1ps
`include "defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 04:18:23 PM
// Design Name: 
// Module Name: alu_cu
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


module alu_cu(input [1:0] AluOp, input [2:0]inst1,input inst2,output reg[3:0] sel

    );   
always @(*)
begin
if(AluOp==2'b00) //Load + Store
sel=`ALU_ADD;

//B type
if(AluOp==2'b01)
sel=`ALU_SUB;



//R type
if(AluOp==2'b10 & inst1==3'b000 & inst2==1'b0) //add
sel= `ALU_ADD;
if(AluOp==2'b10 & inst1==3'b000 & inst2==1'b1) //sub
sel=`ALU_SUB;
if(AluOp==2'b10 & inst1==3'b111 & inst2==1'b0) //and
sel=`ALU_AND;
if(AluOp==2'b10 & inst1==3'b110 & inst2==1'b0) //or
sel=`ALU_OR;
if(AluOp==2'b10 & inst1==3'b100 & inst2==1'b0) //XOR
sel = `ALU_XOR;
if(AluOp==2'b10 & inst1==3'b001 & inst2==1'b0) //SLL
sel = `ALU_SLL;
if(AluOp==2'b10 & inst1==3'b101 & inst2==1'b0) //SRL
sel = `ALU_SRL;
if(AluOp==2'b10 & inst1==3'b101 & inst2==1'b1) //SRA
sel = `ALU_SRA;
if(AluOp==2'b10 & inst1==3'b010 & inst2==1'b1) //SLT
sel = `ALU_SLT;
if(AluOp==2'b10 & inst1==3'b011 & inst2==1'b0) //SLTU
sel = `ALU_SLTU;

//I type
if(AluOp==2'b11 & inst1==3'b000) //ADDI
sel= `ALU_ADD;
if(AluOp==2'b11 & inst1==3'b111) //ANDI
sel=`ALU_AND;
if(AluOp==2'b11 & inst1==3'b110) //ORI
sel=`ALU_OR;
if(AluOp==2'b11 & inst1==3'b100) //XORI
sel = `ALU_XOR;
if(AluOp==2'b11 & inst1==3'b001) //SLLI
sel = `ALU_SLL;
if(AluOp==2'b11 & inst1==3'b101 & inst2==1'b0) //SRLI
sel = `ALU_SRL;
if(AluOp==2'b11 & inst1==3'b101 & inst2==1'b1) //SRAI
sel = `ALU_SRA;
if(AluOp==2'b11 & inst1==3'b010) //SLTI
sel = `ALU_SLT;
if(AluOp==2'b11 & inst1==3'b011) //SLTIU
sel = `ALU_SLTU;

end
endmodule

