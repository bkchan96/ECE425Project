`timescale 1ns / 1ps

module top_module(WADR, WEN, clk, RADR1, RADR2, EXTDATA, DSEL, ALUOUT, ALUSEL);
    input [3:0] WADR, RADR1, RADR2; //Write Address, Read Address 1, Read Address 2
    input [2:0] ALUSEL; //ALU Operation Select
    input WEN, clk, DSEL; //Write Enable, Clock, Select for MUX
    input [15:0] EXTDATA; //External Data Input
    output [15:0] ALUOUT; //ALU Output

    //Declare all the interconnects between components
    wire [15:0] OUT1, OUT2, MUXOUT; //Register Ouput 1, Register Ouput 2, MUX Output
    
    //Instantiate register file and specify port connections
    REG_FILE_16x16 REG_FILE
    (
        .WADR(WADR),
        .WEN(WEN),
        .clk(clk),
        .RADR1(RADR1),
        .RADR2(RADR2),
        .OUT1(OUT1),
        .OUT2(OUT2),
        .ALUIN(ALUOUT)
    );
    
    //Instantiate the 2 to 1, 16-bit MUX and specify port connections 
    MUX_16bit MUX
    (
        .IN0(OUT2),
        .IN1(EXTDATA),
        .SEL(DSEL),
        .OUT(MUXOUT)
    );
    
    ALU ALU_1
    (
        .S(ALUSEL),
        .A(OUT1),
        .B(MUXOUT),
        .F(ALUOUT)
    );

endmodule
