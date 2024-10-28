`timescale 1ns / 1ps
`include "defines.v"

module n_bit_alu #(parameter N=32)(input [3:0] select, input [N-1:0] a,b,input[5:0] shamt, output reg [N-1:0] result, output zero, output sign, output overflow, output carry
    );
    wire [N-1:0]addsub;
    wire [N-1:0]new;
    wire [N-1:0] shift;
    reg [1:0] shiftsel;
    wire cout;
    assign new = (select==`ALU_ADD)? b: (~b+1);
    RCA #(N) plus(.a(a),.b(new),.sum(addsub), .cout(cout));
    
    always @ (*) begin
     if(select == `ALU_SLL)
     shiftsel = 2'b01;
     else if(select == `ALU_SRL)
     shiftsel = 2'b00;
     else if(select == `ALU_SRA)
     shiftsel = 2'b10;
     
     end
    shifter slr(.sel(shiftsel), .immrs1(a), .immrs2(shamt), .newimm (shift));
     
     
     
     always @(*)
begin
case(select)
`ALU_AND: result = a & b;
`ALU_OR: result = a | b;
`ALU_ADD: result = addsub;
`ALU_SUB: result = addsub;
`ALU_XOR: result = a^b;
`ALU_SLL: result = shift;
`ALU_SRL: result = shift;
`ALU_SRA: result = shift;
`ALU_SLT : result = (a<b)? 1:0;
`ALU_SLTU: result = ({0,a} < {0,b}) ?1:0;
default: result = 1'b0;
endcase
end
assign zero =  ~| result ;
assign sign= result[31];
assign overflow = (a[31]==b[31] && result[31]!=a[31]);
assign carry = cout;
    endmodule