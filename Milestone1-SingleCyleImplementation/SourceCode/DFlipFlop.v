module DFlipFlop
(input clk, input rst, input D,input en, output reg Q);
always @ (posedge clk or posedge rst)
if (rst) begin
Q <= 1'b0;
end 
else if(en==1) begin
Q <= D;
end
endmodule 
