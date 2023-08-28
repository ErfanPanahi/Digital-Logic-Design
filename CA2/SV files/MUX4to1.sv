`timescale 1ns/1ns
module MUX4to1(input [3:0]A,[1:0]N,output w);
assign #(42,39) w = ~ ( ~ ( A[0] & ~N[0] & ~N[1] )
		      & ~ ( A[1] & N[0] & ~N[1] )
		      & ~ ( A[2] & ~N[0] & N[1] ) 
		      & ~ ( A[3] & N[0] & N[1] ) );
endmodule
		    