`timescale 1ns/1ns
module Mult24TB();
	reg [23:0]A,B;
	reg clk = 0, rst = 0 , startMul = 0;
	wire [47:0]Result;
	wire doneMul;
	Mult24Top UUT(clk,rst,startMul,A,B,Result,doneMul);
	always #5 clk <= ~clk;
	initial begin 
		#3 rst = 1;
		#3 rst = 0;
		#13 A = 23'd2;
		#13 B = 23'd2;
		#3 startMul = 1;
		#13 startMul = 0;
		#1013 rst = 1;
		#3 rst = 0;
		#13 A = 23'd100;
		#13 B = 23'd50;
		#3 startMul = 1;
		#13 startMul = 0;
		#1000 $stop;
	end
endmodule

