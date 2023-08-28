`timescale 1ns/1ns
module ones_counter_synable(input [126:0]A,output logic [6:0]N);
int i;
always @ (A) begin
#777 N=7'd0;
for (i=0;i<127;i=i+1) begin
if (A[i] == 1'b1) N=N+1;
end
end
endmodule
