`timescale 1ns/1ns
module Fadder_P2_TB();
logic [3:0]AA,BB;
logic Cii = 0;
wire [3:0]Soo;
logic Coo;
Fadder_P2 #4 UUT(AA,BB,Cii,Soo,Coo);
initial begin
repeat (10) #200 {AA,BB} = $random;
#200 $stop;
end
endmodule
