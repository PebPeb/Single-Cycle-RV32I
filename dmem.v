
//
//	dmem.v
//		Data Memory
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/08/2022
// -------------------------------- //
//	Last Modified: 11/01/2022

// Change Log:
//		11/01/2022 - Added Reset, modes, changed memory to byte addressable


module dmem(a, rd, wd, clk, we, mode, reset);
	input wire 			clk, we, reset;
	input wire [2:0]	mode;
	input wire [31:0]	a, wd;
	output reg [31:0]	rd = 0;
	
	reg [7:0] mem [255:0];
	
	integer i;
	initial begin
		for (i = 0; i < 256; i = i + 1) begin
			mem[i] <= 8'h00;
		end		
	end
		
	always @(posedge clk) begin
		if (we) begin
			case (mode)
				3'b000:	{mem[a], mem[a + 1], mem[a + 2], mem[a + 3]} <= wd;	// 4 byte mode (32 bit)
				3'b001:	{mem[a], mem[a + 1]} <= wd[15:0];					// 2 byte mode (16 bit)
				3'b101:	{mem[a], mem[a + 1]} <= wd[15:0];					// 2 byte mode (16 bit)
				3'b010: mem[a] <= wd[7:0];									// 1 byte mode (8 bit)
				3'b110: mem[a] <= wd[7:0];									// 1 byte mode (8 bit)
				default:{mem[a], mem[a + 1], mem[a + 2], mem[a + 3]} <= wd;	// 4 byte mode (32 bit)
			endcase
		end
	end
	
	always @(posedge clk, a, mode) begin
		case (mode)
			3'b000: rd <= {mem[a], mem[a + 1], mem[a + 2], mem[a + 3]};	// 4 byte mode (32 bit)
			3'b001: rd <= {{16{1'b0}}, mem[a], mem[a + 1]};				// 2 byte not signextended
			3'b101:	rd <= {{16{mem[a][7]}}, mem[a], mem[a + 1]};		// 2 byte signextended
			3'b010: rd <= {{24{1'b0}}, mem[a]};							// 1 byte not signextended
			3'b110: rd <= {{24{mem[a][7]}}, mem[a]};					// 1 byte signextended
			default:rd <= {mem[a], mem[a + 1], mem[a + 2], mem[a + 3]};	// 4 byte mode (32 bit)
		endcase
	end
	
	always @(posedge clk, reset) begin
		if (reset) begin
			for (i = 0; i < 256; i = i + 1) begin
				mem[i] <= 8'h00;
			end	
		end
	end	
	
endmodule
