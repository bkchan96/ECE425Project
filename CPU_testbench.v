`timescale 1ns / 1ps


module CPU_testbench();

reg clk;

CPU u_CPU
(
    .clk(clk)
);

initial 
    begin 
        clk = 0;
        forever #0.5 clk = ~clk;
    end 


endmodule
