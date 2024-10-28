`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2024 03:16:32 PM
// Design Name: 
// Module Name: Full_DP
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


module Full_DP(input clk_IN,rst,ssdCLK, input [1:0] ledSel,input [3:0] ssdSel, output reg [15:0] leds ,output [3:0] Anode,
output [6:0] LED_out
 );
 wire [31:0] inst, PC, imm, readData1, readData2, ALU_op2, ALU_result;
 wire [31:0] DataMem_out;
 reg [31:0] write_RF;
 wire memWrite, ALUsrc, regWrite,branch, memRead, MemtoReg;
 wire [1:0] ALUop;
 wire zeroFlag,overFlow, signFlag, carryFlag;
 wire [3:0] ALU_cu_sel;
 reg branchAND; 
 wire [31:0] branchTarget;
 wire [31:0] PC4;
 wire [31:0] PCinput, PCadd;
 wire clk_200;
 reg [12:0] ssd;
 wire [5:0] shamt;
 wire [31:0] auipc;
 reg jal, jalr;
 reg en;
 clockDivider clk_divider(.clk(ssdCLK), .rst(rst), .clk_out(clk_200));
 pushdownDetector push1(.clk(clk_200),.rst(1'b0), .in(clk_IN), .out(clk)); 

 
 n_bit_register#(32) PCDP(.clk(clk_IN), .rst(rst), .D(PCinput), .load(1'b1),.en(en), .Q(PC));
 InstMem instmem(.addr(PC[7:2]), .data_out(inst));
 rv32_ImmGen immGen(.IR(inst), .Imm(imm));
 control_unit CU(.inst(inst[6:2]), .branch(branch), .memRead(memRead), .MemtoReg(MemtoReg), .ALUop(ALUop), .memWrite(memWrite), .ALUsrc(ALUsrc), .regWrite(regWrite));
 RegFile RF(.rst(rst), .clk(clk_IN), .readReg1(inst[19:15]), .readReg2(inst[24:20]), .writeReg(inst[11:7]), .enable(regWrite),.readData1(readData1), .readData2(readData2),.writeData(write_RF)); 
 RCA #(32) PCadd4 (.a(PC), .b(4), .sum(PC4));


assign PCadd = jalr ? readData1 : PC;
 RCA #(32) branchT (.a(PCadd), .b(imm), .sum(branchTarget));
 
  RCA #(32) utype (.a(PC), .b(imm), .sum(auipc));

 
 assign PCinput = branchAND ? branchTarget : PC4;
 alu_cu ALU_CU(.AluOp(ALUop), .inst1(inst[14:12]), .inst2(inst[30]), .sel(ALU_cu_sel)); 
 assign ALU_op2 = ALUsrc ? imm : readData2;
 assign shamt = (inst[5])? {1'b0, readData2[4:0]}: {1'b0,inst[24:20]}; 
 n_bit_alu ALU(.select(ALU_cu_sel), .a(readData1), .b(ALU_op2),.shamt(shamt), .result(ALU_result), .zero(zeroFlag), .sign(signFlag), .overflow(overFlow), .carry(carryFlag));
 DataMem dataMem(.clk(clk_IN), .MemRead(memRead), .MemWrite(memWrite), .addr(ALU_result[7:0]), .funct3(inst[14:12]), .data_in(readData2), .data_out(DataMem_out));
 



Four_Digit_Seven_Segment_Driver_Optimized sevenseg(.clk(ssdCLK), .num(ssd), .Anode(Anode), .LED_out(LED_out));


always @(posedge clk_200)
begin
case(ledSel)
2'b00: leds = inst[15:0];
2'b01: leds = inst[31:16];
2'b10: leds = {2'b00,ALUop,ALU_cu_sel,zeroFlag,(branch&zeroFlag),memWrite, ALUsrc, regWrite,branch, memRead, MemtoReg};
2'b11: leds= 16'd0;
endcase
end


always @(posedge ssdCLK)
begin
case(ssdSel)
4'b0000: ssd= PC[12:0];
4'b0001: ssd = PC4[12:0];
4'b0010: ssd = branchTarget[12:0];
4'b0011: ssd = PCinput[12:0];
4'b0100: ssd = readData1[12:0];
4'b0101: ssd = readData2[12:0];
4'b0110: ssd = write_RF[12:0];
4'b0111: ssd = imm[12:0];
4'b1000: ssd = imm[12:0];
4'b1001: ssd = ALU_op2[12:0];
4'b1010: ssd = ALU_result[12:0];
4'b1011: ssd = DataMem_out[12:0];
endcase
end
 
 always @(*)
 begin
 if(inst[6:0] ==7'b1110011) //Ecall
 en=0;
 else en=1;

//Write to Register MUX
 if (jalr || jal)
  write_RF = PC4;
  else if(MemtoReg)
  write_RF = DataMem_out;
  else if(inst[6:0] ==7'b0110111)
  write_RF = imm;
  else if(inst[6:0] ==7'b0010111)
  write_RF = auipc;
  else
  write_RF = ALU_result;
  
  //Branch Selection
  if(branch)
begin
if(inst[6:0] == 7'b1101111)
begin
jal=1;
branchAND = 1;
end
else if(inst[6:0] == 7'b1100111)
begin
jalr=1;
branchAND = 1;
end
else
begin
jal=1'b0;
jalr=1'b0;
branchAND=1'b0;
end

case(inst[14:12])
0: if(zeroFlag==1) branchAND=1'b1;
1: if(zeroFlag==0) branchAND=1'b1;
4: if(zeroFlag!=signFlag) branchAND=1'b1;
5: if(zeroFlag==signFlag) branchAND=1'b1;
6: if(carryFlag==0) branchAND=1'b1;
7: if(carryFlag==1) branchAND=1'b1;
default: branchAND= 1'b0;
endcase
end
else
branchAND = 1'b0;
 end

endmodule
