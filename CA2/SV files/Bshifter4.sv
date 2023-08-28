`timescale 1ns/1ns
module Bshifter4(input [3:0]A,[1:0]N,output [3:0]SHO);
MUX4to1 G1({A[2],A[1],A[0],A[3]},N,SHO[3]);
MUX4to1 G2({A[1],A[0],A[3],A[2]},N,SHO[2]);
MUX4to1 G3({A[0],A[3],A[2],A[1]},N,SHO[1]);
MUX4to1 G4({A[3],A[2],A[1],A[0]},N,SHO[0]);
endmodule
		