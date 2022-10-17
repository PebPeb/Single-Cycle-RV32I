
//
//	flopr.v
//		Resetable flip-flop
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/16/2022
// -------------------------------- //
//	Last Modified: 10/16/2022

// Change Log:	NA

module flopr(d, q, clk, reset);
	parameter WIDTH = 32;

	input wire				reset, clk;
	input wire [WIDTH:0]	d;
	output reg [WIDTH:0]	q = 0;
	
	always @(posedge clk, posedge reset) begin
		q <= reset ? {WIDTH{1'b0}} : d;
	end

endmodule
