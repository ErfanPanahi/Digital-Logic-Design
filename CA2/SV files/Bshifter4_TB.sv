`timescale 1ns/1ns
module Bshifter4_TB();
logic [3:0]AA;
logic [1:0]NN;
wire [3:0]SSHO1;
Bshifter4 R(AA,NN,SSHO);
initial begin
#100 AA=4'b1010;
#200 NN=2'b00;
#200 NN=2'b01;
#200 NN=2'b10;
#200 NN=2'b11;
#200 AA=4'b1101;
#200 NN=2'b11;
#200 NN=2'b10;
#200 NN=2'b01;
#200 NN=2'b00;
#200 AA=4'b0001;
#200 NN=2'b00;
#200 NN=2'b01;
#200 NN=2'b10;
#200 NN=2'b11;
#200;
end
endmodule