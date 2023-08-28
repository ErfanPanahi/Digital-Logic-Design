`timescale 1ns/1ns
module WrapperOut_DP(input clk,rst,loadResult,input[31:0] Result,output reg[31:0] OutBus);
	//Aregister
	always @(posedge clk,posedge rst) begin
		if(rst) OutBus <= 32'b0;
		else if(loadResult) OutBus <= Result;
	end
endmodule

module WrapperOut_CU(input clk,rst,doneFP,resultAccepted,output reg resultReady,loadResult);
	reg [1:0] pstate,nstate;
	parameter Empty = 0, Receive = 1, waitAccept = 2, sureAccept = 3;
	
	always @(pstate,doneFP,resultAccepted) begin
		nstate = 0;
		{loadResult,resultReady} = 2'b0;
		case(pstate)
			Empty: begin nstate = doneFP ? Receive : Empty; end
			Receive: begin nstate = doneFP ? Receive : waitAccept; loadResult = 1'b1; end
			waitAccept: begin nstate = resultAccepted ? sureAccept : waitAccept ; resultReady = 1'b1; end
			sureAccept: begin nstate = resultAccepted ? sureAccept : Empty; end

		endcase
	end
	
	always @(posedge clk,posedge rst) begin
		if(rst) pstate <= Empty;
		else pstate <= nstate;
	end
endmodule

module WrapperOut32_Top(input clk,rst,resultAccepted,doneFP,input[31:0] Result,output[31:0] OutBus,output resultReady);
	wire loadResult;
	WrapperOut_DP dp1(clk,rst,loadResult,Result,OutBus);
	WrapperOut_CU cu1(clk,rst,doneFP,resultAccepted,resultReady,loadResult);
endmodule 

module WrapperOut_TB();
	reg [31:0]Result;
	reg clk = 0, rst = 0 , resultAccepted = 0, doneFP = 0;
	wire [31:0]OutBus;
	WrapperOut32_Top UUT(clk,rst,resultAccepted,doneFP,Result,OutBus,resultReady);
	always #5 clk <= ~clk;
	initial begin 
		#3 rst = 1;
		#3 rst = 0;
		#13 Result = 32'b01000000000000000000000000000000;
		#3 doneFP = 1;
		#13 doneFP = 0;
		#2013 rst = 1;
		#3 rst = 0;
		#13 Result = 32'b00111111100000000000000000000000;
		#3 doneFP = 1;
		#13 doneFP = 0;
		#2013 rst = 1;
		#3 rst = 0;
		#13 Result = 32'b00111111101000000000000000000000;
		#3 doneFP = 1;
		#13 doneFP = 0;
		#2000 $stop;
	end
endmodule
