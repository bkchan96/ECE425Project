`timescale 1ns / 1ps

module MUX_16bit(IN0, IN1, SEL, OUT);
    input [15:0] IN0, IN1; //Input 1, Input 2
    input SEL; //Select bit for MUX
    output reg [15:0] OUT; //Output of MUX
    
    always @ (IN0, IN1, SEL)
    begin
        if (SEL == 1)
            OUT = IN1;
        else
            OUT = IN0;
    end
    
endmodule
