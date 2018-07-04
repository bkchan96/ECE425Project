`timescale 1ns / 1ps

module REG_FILE_16x16(WADR, WEN, clk, RADR1, RADR2, OUT1, OUT2, ALUIN);
    input [3:0] WADR, RADR1, RADR2; //Write Address, Read Address 1, Read Address 2
    input WEN, clk; //Write Enable, Clock
    input [15:0] ALUIN; //ALU Result Input
    output reg [15:0] OUT1, OUT2; //Ouput 1, Output 2

    reg [15:0] REGFILE[15:0]; //Declare memory => 16 bits wide x 16 memory locations
    
    always @ (posedge clk)
    begin
        if (WEN == 1)
            REGFILE[WADR] = ALUIN; //Write operation when WEN == 1
        OUT1 = REGFILE[RADR1]; //Read from requested register
        OUT2 = REGFILE[RADR2]; //Read from requested register
    end

endmodule
