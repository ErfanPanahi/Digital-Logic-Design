`timescale 1ns/1ns
module NandTB();
logic aa,bb;
wire ww;
MyNand CUT(aa,bb,ww);
initial begin
#20 aa=0;bb=0;
#30 aa=1;
#30 bb=1;
#30 aa=0;
#30 bb=0;
#30 bb=1;
#30 aa=1;
#30 bb=0;
#50 $stop;
end
endmodule
