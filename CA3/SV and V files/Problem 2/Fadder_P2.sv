`timescale 1ns/1ns
module Fadder_P2 #(parameter n) (input [n-1:0]A,B,input Ci,output [n-1:0]So,output Co);
assign #(n*37,n*36) {Co,So} =  A + B + Ci;
endmodule
