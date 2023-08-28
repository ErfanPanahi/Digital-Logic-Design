`timescale 1ns/1ns
module PartC_TBiii ();
	reg clk = 0, j = 0, rst = 0;
	wire Moore,Mealy,diff,diff2;
	moore10010Q UUT1(clk,rst,j,Moore);
	mealy10010Q UUT2(clk,rst,j,Mealy);
	assign diff = Moore ^ Mealy;
	assign diff2 = diff | Moore | Mealy;
   	always #10 clk <= ~clk; 
    	initial begin
    	#25 j = 1;
    	#17 j = 0;
    	#15 j = 0;
    	#15 j = 1;
    	#20 j = 0;
    	#19 j = 1;
    	#30 $stop;
    	end
endmodule

