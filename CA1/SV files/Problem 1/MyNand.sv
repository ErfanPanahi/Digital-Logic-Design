`timescale 1ns/1ns
module MyNand(input a,b,output w);
wire y;
supply1 Vdd;
supply0 Gnd;
nmos #(3,4,5) T1(y,Gnd,b),T2(w,y,a);
pmos #(5,6,7) T3(w,Vdd,a),T4(w,Vdd,b);
endmodule
