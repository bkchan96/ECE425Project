`timescale 1ns / 1ps

module control(
		input  wire	[3:0]	opcode,
		output reg			branch,
		output reg [2:0]	ALUControl,
		output reg			memwrite, memtoreg,
		output reg			regwrite, ALUSrc);

	always @(*) begin
		/* defaults */
		ALUControl[2:0]	<= 3'b000;
		alusrc			<= 1'b0;
		branch			<= 1'b0;
		memtoreg		<= 1'b0;
		memwrite		<= 1'b0;
		regwrite		<= 1'b1;

		case (opcode)
			4'b0000: begin	/* add */
				ALUControl[2:0]	<= 3'b010;
				alusrc   		<= 1'b0;
			end
			4'b0001: begin	/* addi */
				ALUControl[2:0]	<= 3'b010;
				alusrc   		<= 1'b1;
			end
			4'b0010: begin	/* sub */
				ALUControl[2:0]	<= 3'b110;
				alusrc   		<= 1'b0;
			end
			4'b0011: begin	/* and */
				ALUControl[2:0]	<= 3'b000;
				alusrc   		<= 1'b0;
			end
			4'b0100: begin	/* lw */
				alusrc   		<= 1'b1;
			end
			4'b0101: begin	/* sw */
				aluop[0]  <= 1'b1;
				aluop[1]  <= 1'b0;
				regwrite  <= 1'b0;
			end
			4'b0110: begin	/* bne */
				branch 			<= 1'b1;
				regwrite  		<= 1'b0;
			end
			4'b0111: begin	/* j */
				branch 			<= 1'b1;
				regwrite  		<= 1'b0;
			end
		endcase
	end
endmodule