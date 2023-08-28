`timescale 1ns/1ns
module MUXnand(input a,b,c,d,s0,s1,output w);
wire s0b,s1b,ya,yb,yc,yd;
MyNand2in g1(s0,s0,s0b);
MyNand2in g2(s1,s1,s1b);
MyNand3in g3(a,s0b,s1b,ya);
MyNand3in g4(b,s0,s1b,yb);
MyNand3in g5(c,s0b,s1,yc);
MyNand3in g6(d,s0,s1,yd);
MyNand4in g7(ya,yb,yc,yd,w);
endmodule
