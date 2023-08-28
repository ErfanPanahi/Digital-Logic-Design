`timescale 1ns/1ns
module MUX16to1_TB();
logic [15:0]AA;
logic [3:0]NN;
wire ww;
MUX16to1 R(AA,NN,ww);
initial begin
#100 AA=16'b0101010101010101;
#100 NN=4'd3;
#100 NN=4'd2;
#100 NN=4'd0;
#100 NN=4'd1;
#100 AA=16'b1011011110111011;
#100 NN=4'b1111;
#100 NN=4'b1110;
#100 NN=4'b1111;
#100 NN=4'b1011;
#100 AA=16'b1011111111111111;
#100 NN=4'b1111;
#100 NN=4'b1110;
#100 NN=4'b1100;
#100 NN=4'b1110;
#100 AA=16'd1038;
#100 NN=4'b0000;
#100 NN=4'b0001;
#100 NN=4'b0011;
#100 NN=4'b0111;
#100 NN=4'b1111;
#100 AA=16'd21;
#100 NN=4'd0;
#100 NN=4'd1;
#100 NN=4'd2;
#100 NN=4'd3;
#100 NN=4'd4;
#100 NN=4'd5;
#100;
end
endmodule
