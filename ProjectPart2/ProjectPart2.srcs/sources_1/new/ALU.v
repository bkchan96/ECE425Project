`timescale 1ns / 1ps

module ALU(S, A, B, F);
    input [2:0] S;
    input [15:0] A, B;
    output reg [15:0] F;
    
    always @ (S, A, B)
    begin
        case(S)
            0:F =A&B;
            1:F=A|B;
            2:F=A+B;
            4:F=A&(~B);
            5:F=A|(~B);
            6:F=A-B;
            7:F=A<B;
        endcase
    end

endmodule
