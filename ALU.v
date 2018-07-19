`timescale 1ns / 1ps

module ALU(S, A, B, F, Z);
    input [2:0] S; //select operation
    input [15:0] A, B; //both inputs
    output reg [15:0] F; // output
    output reg Z; //zero flag for when F = 0
    
    always @ (S, A, B)
    begin
        case(S)
            0:F=A&B;
            1:F=A|B;
            2:F=A+B;
            4:F=A&(~B);
            5:F=A|(~B);
            6:F=A-B;
            7:F=A<B;
        endcase
    if (F == 0)
        Z = 1;
    else
        Z = 0;
    end

endmodule
