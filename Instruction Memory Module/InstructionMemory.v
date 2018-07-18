`timescale 1ns / 1ps

module InstructionMemory(clk, BE, BranchADR, InstructionOut);
    input clk, BE; //clk and branch enable
    input [3:0] BranchADR; //address to branch to when BE is 1
    output reg [15:0] InstructionOut; //instruction to output
    
    reg [15:0] instruction[15:0];
    reg [3:0] PC;
    
    //initialize PC to 0
    initial
        PC = 0;
    
    always @(PC)
        InstructionOut = instruction[PC];
    
    always @(clk)
        if (BE)
            PC = BranchADR;
        else
            PC = PC + 1;
    
endmodule
