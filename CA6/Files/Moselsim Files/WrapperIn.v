`timescale 1ns/1ns
module WrapperIn_DP(input clk,rst,ldA,ldB,input[31:0] inBus,output reg[31:0] Ain,Bin);
	//Aregister
	always @(posedge clk,posedge rst) begin
		if(rst) Ain <= 32'b0;
		else if(ldA) Ain <= inBus;
	end
	//Bregister
	always @(posedge clk,posedge rst) begin
		if(rst) Bin <= 32'b0;
		else if(ldB) Bin <= inBus;
	end
endmodule

module WrapperIn_CU(input clk,rst,inReady,output reg inAccept,ldA,ldB,startFP);
	reg [2:0] pstate,nstate;
	parameter Idle1 = 0, Load1 = 1, Accept1 = 2, Idle2 = 3, Load2 = 4, Accept2 = 5;

	always @(pstate,inReady) begin
		nstate = 0;
		{ldA,ldB,inAccept,startFP} = 4'b0;
		case(pstate)
			Idle1: begin nstate = inReady ? Load1 : Idle1; end
			Load1: begin nstate = Accept1; ldA = 1'b1; end
			Accept1: begin nstate = inReady ? Accept1 : Idle2 ; inAccept = 1'b1; end
			Idle2: begin nstate = inReady ? Load2 : Idle2; end
			Load2: begin nstate = Accept2; ldB = 1'b1; end
			Accept2: begin nstate = inReady ? Accept2 : Idle1; inAccept = 1'b1; startFP = 1'b1; end
		endcase
	end
	
	always @(posedge clk,posedge rst) begin
		if(rst) pstate <= Idle1;
		else pstate <= nstate;
	end
endmodule


module Wrapper32In_Top(input clk,rst,inReady,input[31:0] inBus,output[31:0] Ain,Bin,output inAccept,startFP);
	wire ldA,ldB;
	WrapperIn_DP dp1(clk,rst,ldA,ldB,inBus,Ain,Bin);
	WrapperIn_CU cu1(clk,rst,inReady,inAccept,ldA,ldB,startFP);
endmodule 

module WrapperIn_TB();
	reg [31:0]inBus;
	reg clk = 0, rst = 0 , inReady = 0;
	wire [31:0]Ain,Bin;
	Wrapper32In_Top UUT(clk,rst,inReady,inBus,Ain,Bin,inAccept,startFP);
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
		#503 inBus = 32'b01000000001000000000000000000000;
		#23 inReady = 1;
		#13 inReady = 0;
		#2000 $stop;
	end
endmodule

