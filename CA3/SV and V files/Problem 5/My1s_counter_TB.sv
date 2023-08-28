`timescale 1ns/1ns
module My1s_counter127_TB();
logic signed [126:0]AA;
wire [6:0]NN;
My1s_counter127 UUT(AA,NN);
initial begin
AA = 127'd63;
#1000 AA = 127'd15;
#1000 AA = 127'd1;
#1000 AA = 127'd7;
#1000 AA = 127'd127;
#1000 AA = 127'd0;
#1000 AA[126] = 1'b1;
repeat (126) #1000 AA = AA >>> 1;
#1000 $stop;
end
endmodule
