`timescale 1ns/1ns
module Final_Top(input clk,rst,inReady,resultAccepted,input[31:0] inBus,output[31:0] OutBus,output inAccept,startFP,doneFP,doneMul,startMul,resultReady);
	wire P47;
	wire ldA,ldB,loadA,loadB,loadP,initP,loadResult;
	wire[31:0]Ain,Bin,Result;
	WrapperIn_DP dp1(clk,rst,ldA,ldB,inBus,Ain,Bin);
	WrapperIn_CU cu1(clk,rst,inReady,inAccept,ldA,ldB,startFP);
	MultFP32_DP dp2(clk,rst,loadA,loadB,initP,loadP,startMul,Ain,Bin,Result,P47,doneMul);
  	MultFP32_CU cu2(clk,rst,startFP,doneMul,P47,loadA,loadB,initP,loadP,startMul,doneFP);
	WrapperOut_DP dp3(clk,rst,loadResult,Result,OutBus);
	WrapperOut_CU cu3(clk,rst,doneFP,resultAccepted,resultReady,loadResult);
endmodule 

module Final_TB();
	reg [31:0]inBus;
	reg clk = 0, rst = 0 , inReady = 0 ,resultAccepted = 0;
	wire [31:0]OutBus;
	wire inAccept,startFP,doneFP,doneMul,startMul,resultReady;
	Final_Top UUT(clk,rst,inReady,resultAccepted,inBus,OutBus,inAccept,startFP,doneFP,doneMul,startMul,resultReady);

	always #5 clk <= ~clk;
	initial begin 
		#3 rst = 1;
		#3 rst = 0;
		#13 inBus = 32'b01000000000000000000000000000000;
		#3 inReady = 1;
		#13 inReady = 0;
		#503 inBus = 32'b00111111100000000000000000000000;
		#23 inReady = 1;
		#13 inReady = 0;
		#2003 rst = 1;
		#3 rst = 0;
		#13 inBus = 32'b01000000000000000000000000000000;
		#3 inReady = 1;
		#13 inReady = 0;
		#503 inBus = 32'b01000000000000000000000000000000;
		#23 inReady = 1;
		#13 inReady = 0;
		#2000 $stop;
	end
endmodule 
