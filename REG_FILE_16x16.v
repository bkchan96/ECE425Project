`timescale 1ns / 1ps

module REG_FILE_16x16(WADR, WEN, clk, RADR1, RADR2, OUT1, OUT2, DIN);
    input [3:0] WADR, RADR1, RADR2; //Write Address, Read Address 1, Read Address 2
    input WEN, clk; //Write Enable, Clock
    input [15:0] DIN; //Data in
    output reg [15:0] OUT1, OUT2; //Ouput 1, Output 2

    reg [15:0] REGFILE[15:0]; //Declare memory => 16 bits wide x 16 memory locations
    
    integer i; //Declare counter for use in a for loop later
    
    //Initialize all register entries to 0
    initial
    begin
        for(i = 0; i < 16; i=i+1)
        begin
            REGFILE[i] = 0;
        end
    end
    
    //Run function of register file
    always @ (posedge clk)
    begin
        if (WEN == 1)
            REGFILE[WADR] = DIN; //Write operation when WEN == 1
    end
    
    always @ (*)
    begin
        OUT1 = REGFILE[RADR1]; //Read from requested register
        OUT2 = REGFILE[RADR2]; //Read from requested register
    end

endmodule
