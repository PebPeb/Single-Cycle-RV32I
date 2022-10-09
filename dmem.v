
//
//	dmem.v
//		Data Memory
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/08/2022
// -------------------------------- //
//	Last Modified: 10/08/2022

// Change Log:	NA


module dmem(a, rd, wd, clk, we);
	input wire 			clk, we;
	input wire [31:0]	a, wd;
	output wire [31:0]	rd;
	
	reg [31:0] mem [255:0];
	
	integer i;
	initial begin
		for (i = 0; i < 256; i = i + 1) begin
			mem[i] <= 32'h00000000;
		end		
	end
	
	assign rd = mem[a[31:2]];
	
	always @(posedge clk) begin
		if (we) begin
			mem[a[31:2]] <= wd;
		end
	end
	
	
endmodule
