`timescale 1ns / 1ps

module IM(clk, BE, BranchADR, IOut);
    input clk, BE; //clk and branch enable
    input [3:0] BranchADR; //address to branch to when BE is 1
    output reg [15:0] IOut; //instruction to output
    
    reg [15:0] instruction[15:0]; //instruction memory locations
    reg [3:0] PC; //program counter
    
    integer i; //variable for for loop
    
    initial
    begin
        //initialize everything to zero first
        for(i = 0; i < 16; i = i + 1)
            instruction[i] = 0;
            
        //load all instructions
        instruction[0] = 16'b0001000100000101;  //addi $s0, $0, 5
        instruction[1] = 16'b0001001000000010;  //addi $s1, $0, 2
        instruction[2] = 16'b0001001100000001;  //addi $s2, $0, 1
        instruction[3] = 16'b0101000100110000;  //sw $s0 0($s2)
        instruction[4] = 16'b0101001000110001;  //sw $s1 4($s2)
        instruction[5] = 16'b0010010000010010;  //sub $s3 $s0 $s1
        instruction[6] = 16'b0011010100010010;  //and $s4 $s0 $s1
        instruction[7] = 16'b0110001101001100;  //bne $s0, $s3, Done 
        instruction[8] = 16'b0100000100110000;  //lw $s0 0($s2) 
        instruction[9] = 16'b0111000000001100;  //j Done
        instruction[12] = 16'b0100001000110100; //done: lw $s1 4($s2)
        instruction[15] = 16'b0111000000001111; //loop forever to hold values
    end
    
    //initialize PC to 0
    initial
        PC = 0;
    
    always @(PC)
        IOut = instruction[PC];
    
    always @(clk)
        if (BE)
            PC = BranchADR;
        else
            PC = PC + 1;
    
endmodule
