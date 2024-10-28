`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 02:59:06 PM
// Design Name: 
// Module Name: RegFile
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


module RegFile #(parameter N=32)(input rst,input clk,input [4:0] readReg1,readReg2,writeReg,input enable,input [N-1:0] writeData,
output [N-1:0] readData1, readData2  );
reg [N-1:0] Regfile[31:0];

assign readData1 = Regfile[readReg1];
assign readData2 = Regfile[readReg2];


integer j;
always @(posedge clk or posedge rst)
begin
if(rst)
begin
for(j=0; j<32; j=j+1)
Regfile[j]= 1'b0;
end
else if(enable==1 && writeReg !=0)
Regfile[writeReg] = writeData;

end
endmodule
