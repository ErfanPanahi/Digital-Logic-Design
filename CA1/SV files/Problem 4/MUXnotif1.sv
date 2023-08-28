`timescale 1ns/1ns
module MUXnotif1(input a,b,c,d,s0,s1,output w);
wire s0b,s1b,x,y;
supply1 Vdd;
MyNOTIF1 g1(s0,Vdd,s0b);
MyNOTIF1 g2(s1,Vdd,s1b);
MyNOTIF1 g3(a,s0b,x);
MyNOTIF1 g4(b,s0,x);
MyNOTIF1 g5(c,s0b,y);
MyNOTIF1 g6(d,s0,y);
MyNOTIF1 g7(x,s1b,w);
MyNOTIF1 g8(y,s1,w);
endmodule