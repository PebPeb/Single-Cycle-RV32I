
//
//	imem.v
//		Instruction Memory
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/06/2022
// -------------------------------- //
//	Last Modified: 01/19/2023

// Change Log:	NA


module imem(a, rd);
	input wire [31:0]	a;
	output wire [31:0]	rd;
	
	reg [31:0] mem [0:63];

	parameter INITIAL_DATA_PATH = "/home/pigeonlord9000/Desktop/Single-Cycle-RV32I/imem.dat";
	
	initial begin
		$readmemh(INITIAL_DATA_PATH, mem);
	end
	
	assign rd = mem[a[31:2]];

endmodule
