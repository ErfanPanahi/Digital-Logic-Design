`timescale 1ns/1ns
module MUX16to1(input [15:0]A,[3:0]N,output w);
wire [3:0]x;
MUX4to1 g1({A[15],A[14],A[13],A[12]},{N[1],N[0]},x[3]);
MUX4to1 g2({A[11],A[10],A[9],A[8]},{N[1],N[0]},x[2]);
MUX4to1 g3({A[7],A[6],A[5],A[4]},{N[1],N[0]},x[1]);
MUX4to1 g4({A[3],A[2],A[1],A[0]},{N[1],N[0]},x[0]);
MUX4to1 g5(x,{N[3],N[2]},w);
endmodule
