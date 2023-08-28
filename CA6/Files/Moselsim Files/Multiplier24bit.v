`timescale 1ns/1ns
module Mult24DP(input clk,rst,loadA,loadB,loadP,shiftA,initP,Bsel,input [23:0]ABus,BBus,output [47:0]ResultBus,output A0);
	reg [23:0]Areg,Breg,Preg;
	wire [23:0]B_and;
	wire [24:0]add_Bus;
	//Bregister
	always @(posedge clk,posedge rst) begin
		if(rst) Breg <= 24'b0;
		else if(loadB) Breg <= BBus;
	end
	//Pregister
	always @(posedge clk,posedge rst) begin
		if(rst) Preg <= 24'b0;
		else begin
			if(initP) Preg <= 24'b0;
			else if(loadP) Preg <= add_Bus [24:1];
		end
	end
	//Ashift-register
	always @(posedge clk,posedge rst) begin
		if(rst) Areg <= 24'b0;
		else begin
			if(loadA) Areg <= ABus;
			else if(shiftA) Areg <= {add_Bus[0],Areg[23:1]};
		end
	end
	
	assign B_and = Bsel ? Breg : 24'b0;
	assign add_Bus = B_and + Preg;
	assign ResultBus = {Preg,Areg};
	assign A0 = Areg[0];

endmodule

module Mult24CU(input clk,rst,start,A0,output reg loadA,shiftA,loadB,loadP,initP,Bsel,ready);
	wire Co;
	reg init_counter,inc_counter;
	reg [1:0] pstate,nstate;
	reg [4:0] count;
	parameter Idle = 0,Init = 1, Load = 2, Shift = 3;
	//Counter
	always @(pstate,start,A0,Co) begin
		nstate = 0;
		{loadA,shiftA,loadB,loadP,initP,Bsel,ready} = 7'b0;
		{init_counter,inc_counter} = 2'b0;
		case(pstate)
			Idle: begin nstate = start ? Init : Idle; ready = 1'b1; end
			Init: begin nstate = start ? Init : Load; init_counter = 1'b1;initP = 1'b1; end
			Load: begin nstate = Shift; loadA = 1'b1; loadB = 1'b1; end
			Shift: begin nstate = Co ? Idle : Shift; loadP = 1'b1; shiftA = 1'b1; inc_counter = 1'b1; Bsel = A0; end
		endcase
	end
	
	always @(posedge clk,posedge rst) begin
		if(rst) pstate <= Idle;
		else pstate <= nstate;
	end

	always @(posedge clk,posedge rst) begin
		if(rst) count <= 5'd0;
		else begin
			if(init_counter) count <= 5'd8;
			else if(inc_counter) count <= count + 1'd1;
		end
	end

	assign Co = & count;

endmodule


module Mult24Top(input clk,rst,start,input [23:0]A,B,output [47:0] ResultBus,output ready);
	wire A0;
	wire loadA,shiftA,loadB,loadP,initP,Bsel;
	//wire [47:0]ResultBus48bit;

	Mult24DP dp(clk,rst,loadA,loadB,loadP,shiftA,initP,Bsel,A,B,ResultBus,A0);
  	Mult24CU co(clk,rst,start,A0,loadA,shiftA,loadB,loadP,initP,Bsel,ready);

	//assign ResultBus = ResultBus48bit[47:24];
endmodule