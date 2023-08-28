`timescale 1ns/1ns
module My1s_counter_P4_synable(input [126:0]A,output [6:0]N);
wire [63:0]B;
wire [47:0]C;
wire [31:0]D;
wire [19:0]E;
wire [11:0]F;
genvar i;
generate
for (i=0;i<32;i=i+1) begin: Fa1bit
assign #(1*37,1*36) {B[2*i+1],B[2*i]} = A[3*i+1] + A[3*i] + A[3*i+2];
end
for (i=0;i<16;i=i+1) begin: Fa2bit
assign #(2*37,2*36) {C[3*i+2],C[3*i+1],C[3*i]} = {B[4*i+3],B[4*i+2]} + {B[4*i+1],B[4*i]} + A[96+i];
end
for (i=0;i<8;i=i+1) begin: Fa3bit
assign #(3*37,3*36) {D[4*i+3],D[4*i+2],D[4*i+1],D[4*i]} = {C[6*i+5],C[6*i+4],C[6*i+3]} + {C[6*i+2],C[6*i+1],C[6*i]} + A[112+i];
end
for (i=0;i<4;i=i+1) begin: Fa4bit
assign #(4*37,4*36) {E[5*i+4],E[5*i+3],E[5*i+2],E[5*i+1],E[5*i]} = {D[8*i+7],D[8*i+6],D[8*i+5],D[8*i+4]} + {D[8*i+3],D[4*i+2],D[8*i+1],D[8*i]} + A[120+i];
end
for (i=0;i<2;i=i+1) begin: Fa5bit
assign #(5*37,5*36) {F[6*i+5],F[6*i+4],F[6*i+3],F[6*i+2],F[6*i+1],F[6*i]} = {E[10*i+9],E[10*i+8],E[10*i+7],E[10*i+6],E[10*i+5]} + {E[10*i+4],E[10*i+3],E[10*i+2],E[10*i+1],E[10*i]} + A[124+i];
end
for (i=0;i<1;i=i+1) begin: Fa6bit
assign #(6*37,6*36) N = {F[12*i+11],F[12*i+10],F[12*i+9],F[12*i+8],F[12*i+7],F[12*i+6]} + {F[12*i+5],F[12*i+4],F[12*i+3],F[12*i+2],F[12*i+1],F[12*i]} + A[126+i];
end
endgenerate
endmodule

