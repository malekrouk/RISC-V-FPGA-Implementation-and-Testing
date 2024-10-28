`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2024 07:50:18 PM
// Design Name: 
// Module Name: shifter
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


module shifter( input [1:0] sel, [31:0] immrs1, [5:0]immrs2, output reg [31:0] newimm
    );
    integer j;
    always @(*) begin
    if(sel==2'b00) begin //srl
     newimm= {1'b0, immrs1[31:1] };
    for(j = 1; j < immrs2; j = j+1)
        newimm= {1'b0, newimm[31:1] }; 
   end
    if (sel==2'b01)
    begin //sll
     newimm= {immrs1[30:0],1'b0};
    for(j = 1; j < immrs2; j = j+1)
        newimm= {newimm[30:0],1'b0};
   end
    if (sel==2'b10)
     begin //sra
     newimm= {immrs1[31], immrs1[31:1] };
    for(j = 1; j < immrs2; j = j+1)
        newimm= {newimm[31], newimm[31:1] }; 
   end
   
    if (sel==2'b11)
    begin //sll
     newimm= {immrs1[30:0],1'b0};
    for(j = 1; j < 12; j = j+1)
        newimm= {newimm[30:0],1'b0};
   end
    end
   
   
    
    
    
endmodule
