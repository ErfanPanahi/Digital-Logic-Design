`timescale 1ns/1ns
module Fadder_P1_TB();
logic aa=0,bb=0,cii=0;
wire soo,coo;
Fadder_P1 UUT(aa,bb,cii,soo,coo);
initial begin
#100 aa = 1;
#100 bb = 1;
#100 bb = 0; 
#100 aa = 0;
#100 cii = 1;
#100 aa = 1;
#100 aa = 0; 
#100 $stop;
end
endmodule
