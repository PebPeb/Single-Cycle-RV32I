
//
//	imem.v
//		Instruction Memory
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/06/2022
// -------------------------------- //
//	Last Modified: 10/08/2022

// Change Log:	NA


module imem(a, rd);
	input wire [31:0]	a;
	output reg [31:0]	rd;
	
	reg [31:0] mem [63:0];
	
	initial begin
		mem[0] = 32'h0000000F;
		mem[1] = 32'h000000F0;
		mem[2] = 32'h00000F00;
		mem[3] = 32'h0000F000;
		mem[4] = 32'h000F0000;
		mem[5] = 32'h00F00000;
		mem[6] = 32'h0F000000;
		mem[7] = 32'hF0000000;
	end
	
	
	always @(a) begin
		rd <= mem[a[31:2]];
	end

endmodule
