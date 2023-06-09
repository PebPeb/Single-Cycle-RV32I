
//
//	mux2.v
//		Adjustable data width mux 2
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 09/30/2022
// -------------------------------- //
//	Last Modified: 09/30/2022

// Change Log:	NA


module mux2(a, b, sel, y);
	parameter WIDTH = 32;
	
	input wire [WIDTH - 1:0]	a, b;
	input wire 					sel;
	output wire [WIDTH - 1:0]	y;

	assign y = sel ? b : a;

endmodule
