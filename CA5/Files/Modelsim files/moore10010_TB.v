`timescale 1ns/1ns
module moore10010_TB ();
    reg clk = 0, j = 0, rst = 0;
    wire w_moore;
    moore10010 UUT1(clk,rst,j,w_moore);
    always #10 clk <= ~clk; 
    initial begin
    #25 j = 1;
    #17 j = 0;
    #15 j = 0;
    #15 j = 1;
    #20 j = 0;
    #19 j = 1;
    #25 j = 1;
    #17 j = 0;
    #15 j = 0;
    #15 j = 1;
    #20 j = 0;
    #19 j = 1;
    #30 $stop;
    end
endmodule

