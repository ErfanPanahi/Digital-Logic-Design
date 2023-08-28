`timescale 1ns/1ns
module MUXcompareTB();
logic aa=1,bb=0,cc=0,dd=1,s0,s1;
wire w3,w4;
MUXnand CUT(aa,bb,cc,dd,s0,s1,w3);
MUXnotif1 CUT1(aa,bb,cc,dd,s0,s1,w4);
initial begin
    #50 aa=1;bb=0;cc=0;dd=1;
    #50 s0=0;s1=0;
    #50 s0=1;
    #50 s1=0;
    #50 s1=1;
    #50 s0=1;
    #50 s1=0;
    #50 s0=0;
    #50 s0=1;
    #50 s1=1;
    #50 s0=0;
    #50 s1=0;
    #50 aa=0;bb=1;cc=0;dd=1;
    #50 s0=0;s1=0;
    #50 s0=1;
    #50 s1=0;
    #50 s1=1;
    #50 s0=1;
    #50 s1=0;
    #50 s0=0;
    #50 s0=1;
    #50 s1=1;
    #50 s0=0;
    #50 s1=0;
    #50 $stop;
end
endmodule