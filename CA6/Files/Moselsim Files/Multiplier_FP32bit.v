`timescale 1ns/1ns
module MultFP32_DP(input clk,rst,loadA,loadB,initP,loadP,startMul,input[31:0] Ain,Bin,output[31:0] Result,output P47,doneMul);
	reg[31:0] Areg,Breg,Preg;
	reg[7:0] Aexp,Bexp;
	wire[47:0] mul24Bus;
	Mult24Top MUL(clk,rst,startMul,{1'b1,Areg[22:0]},{1'b1,Breg[22:0]},mul24Bus,doneMul);

	//Aregister
	always @(posedge clk,posedge rst) begin
		if(rst) Areg <= 32'b0;
		else if(loadA) Areg <= Ain;
	end
	//Bregister
	always @(posedge clk,posedge rst) begin
		if(rst) Breg <= 32'b0;
		else if(loadB) Breg <= Bin;
	end
	always @(posedge clk,posedge rst) begin
		if(rst) Preg <= 24'b0;
		else begin
			if(initP) Preg <= 24'b0;
			else if(loadP) Preg <= mul24Bus[46:23];
		end
	end	
	
	assign Result[31] = (Areg[31] ^ Breg[31]);
	assign P47 = mul24Bus[47];
	assign Aexp = Areg[30:23];
	assign Bexp = Breg[30:23];
	assign Result[30:23] = (Aexp + Bexp) - 8'd127 + P47;
	assign Result[22:0] = P47 ? mul24Bus[46:24] : mul24Bus[45:23];

endmodule

module MultFP32_CU(input clk,rst,startFP,doneMul,P47,output reg loadA,loadB,initP,loadP,startMul,doneFP);
	reg [2:0] pstate,nstate;
	parameter Idle = 0, Init = 1, Load1 = 2, Mul24 = 3, Load2 = 4, Calc = 5;
	
	always @(pstate,doneMul,startFP,P47) begin
		nstate = 0;
		{loadA,loadB,initP,loadP,startMul,doneFP} = 6'b0;
		case(pstate)
			Idle: begin nstate = startFP ? Init : Idle;  end
			Init: begin nstate = startFP ? Init : Load1; initP = 1'b1; end
			Load1: begin nstate = Mul24; loadA = 1'b1; loadB = 1'b1; end
			Mul24: begin nstate = doneMul ? Load2 : Mul24; startMul = 1'b1; end
			Load2: begin nstate = Calc; loadP = 1'b1; end
			Calc: begin nstate = Idle; doneFP = 1'b1; end
		endcase
	end
	
	always @(posedge clk,posedge rst) begin
		if(rst) pstate <= Idle;
		else pstate <= nstate;
	end
endmodule

module MultFP32_Top(input clk,rst,startFP,input[31:0] A,B,output[31:0] Result,output doneFP,doneMul,startMul);
	wire P47;
	wire loadA,loadB,loadP,initP;

	MultFP32_DP dp(clk,rst,loadA,loadB,initP,loadP,startMul,A,B,Result,P47,doneMul);
  	MultFP32_CU cu(clk,rst,startFP,doneMul,P47,loadA,loadB,initP,loadP,startMul,doneFP);
endmodule 

module MultFP32_TB();
	reg [31:0]A,B;
	reg clk = 0, rst = 0 , startFP = 0;
	wire [31:0]Result;
	wire doneFP,doneMul,startMul;
	MultFP32_Top UUT(clk,rst,startFP,A,B,Result,doneFP,doneMul,startMul);
	always #5 clk <= ~clk;
	initial begin 
		#3 rst = 1;
		#3 rst = 0;
		#13 A = 32'b01000000000000000000000000000000;
		#13 B = 32'b00111111001000000000000000000000;
		#3 startFP = 1;
		#13 startFP = 0;
		#2013 rst = 1;
		#3 rst = 0;
		#13 A = 32'b00111111100000000000000000000000;
		#13 B = 32'b00111111100000000000000000000000;
		#3 startFP = 1;
		#13 startFP = 0;
		#1013 rst = 1;
		#3 rst = 0;
		#13 A = 32'b00111111100000000000000000000000;
		#13 B = 32'b01000000001000000000000000000000;
		#3 startFP = 1;
		#13 startFP = 0;
		#2000 $stop;
	end
endmodule 