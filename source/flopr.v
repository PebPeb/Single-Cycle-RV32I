
//
//	flopr.v
//		Resetable flip-flop
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/16/2022
// -------------------------------- //
//	Last Modified: 01/19/2023

// Change Log:	NA

module flopr(d, q, clk, reset);
	parameter WIDTH = 32;
	parameter INIT = 0;

	input wire				reset, clk;
	input wire [WIDTH - 1:0]	d;
	output reg [WIDTH - 1:0]	q;
	
	initial q = INIT;
	always @(posedge clk, posedge reset) begin
		q <= reset ? {WIDTH{1'b0}} : d;
	end

endmodule
