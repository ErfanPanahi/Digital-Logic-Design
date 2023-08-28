`timescale 1ns/1ns
module MyNand2in(input a,b,output w);
wire y;
supply1 Vdd;
supply0 Gnd;
pmos #(5,6,7) T1(w,Vdd,a),T2(w,Vdd,b);
nmos #(3,4,5) T3(y,Gnd,b),T4(w,y,a);
endmodule

module MyNand3in(input a,b,c,output w);
wire x,y;
supply1 Vdd;
supply0 Gnd;
pmos #(5,6,7) T1(w,Vdd,a),T2(w,Vdd,b),T3(w,Vdd,c);
nmos #(3,4,5) T4(y,Gnd,c),T5(x,y,b),T6(w,x,a);
endmodule

module MyNand4in(input a,b,c,d,output w);
wire x,y,z;
supply1 Vdd;
supply0 Gnd;
pmos #(5,6,7) T1(w,Vdd,a),T2(w,Vdd,b),T3(w,Vdd,c),T4(w,Vdd,d);
nmos #(3,4,5) T5(z,Gnd,d),T6(y,z,c),T7(x,y,b),T8(w,x,a);
endmodule
