`timescale 1ns / 1ps

module CPU(clk);
    input clk;
    
    wire [15:0] REG_OUT1, REG_OUT2, MUXtoALU, ALUOUT, MMOUT, IOUT;
    wire [2:0] ALUC;
    wire MW, MR, ALUSRC, RW;
    wire [3:0] OPCODE, FIELD1, FIELD2, FIELD3;
    wire [3:0] RADR2MUXOUT;
    
    assign {OPCODE, FIELD1, FIELD2, FIELD3} = IOUT;
    
    wire Z, B, BE;
    assign BE = Z & B;
    
    CONTROL uCONTROL(
        .opcode(OPCODE),      //[3:0]
        .branch(B),      //1 bit
        .ALUControl(ALUC),  //[2:0]
        .memwrite(MW),    //1 bit
        .memtoreg(MR),    //1 bit
        .regwrite(RW),    //1 bit
        .alusrc(ALUSRC)       //1 bit
    );
    
    ALU uALU(
        .S(ALUC),           //[2:0] select
        .A(REG_OUT1),           //[15:0] input a
        .B(MUXtoALU),           //[15:0] input b
        .F(ALUOUT),           //[15:0] output f
        .Z(Z)            //1 bit zero flag
    );
    
    MUX_16bit uALUMUX(
        .IN0(REG_OUT2),
        .IN1({12'b000000000000, FIELD3}),
        .SEL(ALUSRC),
        .OUT(MUXtoALU)
    );
    
    MUX_4bit uRADR2MUX(
        .IN0(FIELD3),
        .IN1(FIELD1),
        .SEL(MW),
        .OUT(RADR2MUXOUT)
    );
    
    IM uIM(
        .clk(clk),             //clock
        .BE(BE),              //1 bit branch enable
        .BranchADR(FIELD3),       //[3:0] branch address
        .IOut(IOUT)             //[15:0]instruction out
    );
    
    REG_FILE_16x16 uREG_FILE(
        .WADR(FIELD1),            //[3:0] write address
        .WEN(RW),             //1 bit write enable
        .clk(clk),             //clock
        .RADR1(FIELD2),           //[3:0] read address 1
        .RADR2(RADR2MUXOUT),   //[3:0] read address 1
        .OUT1(REG_OUT1),            //[15:0] output 1
        .OUT2(REG_OUT2),            //[15:0] output 2
        .DIN(MMOUT)              //[15:0] data in 
    );
    
    MM UMM(
        .ALUIN(ALUOUT),       //[15:0] input from alu
        .WD(REG_OUT2),  //[15:0] write data
        .WE(MW),      //1 bit write enable
        .clk(clk),     //clock
        .MR(MR),      //1 bit MemtoReg
        .OUT(MMOUT)      //[15:0] output
    );
endmodule
