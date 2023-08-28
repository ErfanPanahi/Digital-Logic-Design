`timescale 1ns/1ns
module NOTIF1TB();
logic aa,enn;
wire ww;
MyNOTIF1 CUT(aa,enn,ww);
initial begin
#20 aa=0;enn=0;
#30 enn=1;
#30 enn=0;
#30 aa=1;
#30 enn=1;
#30 enn=0;
#30 aa=0;
#30 enn=1;
#30 aa=1;
#30 aa=0;
#30 enn=0;
#50 $stop;
end
endmodule
