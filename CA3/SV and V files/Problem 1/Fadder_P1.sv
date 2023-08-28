`timescale 1ns/1ns
module Fadder_P1(input a,b,ci,output so,co);
wire si,x,y;
assign #(17,19) si = a ^ b;
assign #(17,19) so = si ^ ci;
nand #(10,8) (x,a,b);
nand #(10,8) (y,si,ci);
nand #(10,8) (co,x,y);
endmodule
