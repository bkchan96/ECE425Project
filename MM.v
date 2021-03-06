module MM(ALUIN,WD,WE,clk,MR,OUT);
    input [15:0] ALUIN; //Input form ALU 
    input WE, clk, MR; // Write Enable, Clock, Memory to Register 
    input [15:0] WD; //register file
    reg [15:0] MEMOUT; //Selected output Data from Memory
    output [15:0] OUT; //Output Form the Muxes
    
    reg [15:0] REGFILE[15:0]; 
    
    MUX_16bit uMUX_16bit // Muxes 
    (
        .IN0(ALUIN), 
        .IN1(MEMOUT), 
        .SEL(MR), 
        .OUT(OUT)
    );
    
    integer i;
    initial
    begin
        for(i = 0; i < 16; i = i + 1)
            REGFILE[i] = 0;
    end
    
    always @ (posedge clk)
    begin
        if (WE == 1)
            REGFILE[ALUIN[3:0]] = WD; //Write operation when WEN == 1
    end
    
    always @(*)
    begin
        MEMOUT = REGFILE[ALUIN[3:0]]; //Read from requested register
    end
    
endmodule
