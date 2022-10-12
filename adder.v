
//
//	adder.v
//		Adjustable data width adder
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/11/2022
// -------------------------------- //
//	Last Modified: 10/11/2022

// Change Log:	NA


module adder(a, b, y);
	parameter WIDTH = 32;
	
	input wire [WIDTH - 1:0]	a, b;
	output wire [WIDTH - 1:0]	y;

	assign y = a + b;

endmodule
