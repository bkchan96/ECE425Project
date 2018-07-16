module DataMem(
		input wire			clk, we
		input wire	[15:0]	addr, wdata, rdata

	reg [15:0] mem [0:65535];  // 16-bit memory with 65536 entries (2^16)

	always @(posedge clk) begin
		if (we) begin
			mem[addr] <= wdata;
		end
	end

	assign rdata = we ? wdata : mem[addr][15:0]; // To read from incoming data rather than memory

endmodule