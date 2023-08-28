`timescale 1ns/1ns
module MyNOTIF1(input a,en,output w);
wire x,y,z;
supply1 Vdd;
supply0 Gnd;
pmos #(5,6,7) T1(x,Vdd,a),T2(w,x,y),TI1(y,Vdd,en);
nmos #(3,4,5) T3(z,Gnd,a),T4(w,z,en),TI2(y,Gnd,en);
endmodule
