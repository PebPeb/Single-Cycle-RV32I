
//
//	alu32.v
//		32 bit ALU for the RV32I implement
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/03/2022
// -------------------------------- //
//	Last Modified: 10/24/2022

// Change Log:	NA


module alu32(a, b, ALUControl, result);
	input wire [31:0]	a, b;
	input wire [3:0]	ALUControl;
	output reg [31:0]	result;

	wire signed [31:0]	a_signed, b_signed;

	assign a_signed = a;
	assign b_signed = b;

	always @(*) begin
		case (ALUControl)
			4'b0000: result <= a + b;
			4'b0001: result <= a - b;
			4'b0010: result <= a & b;
			4'b0011: result <= a | b;
			4'b0100: result <= a ^ b;
			4'b0101: result <= a << b[4:0];		// Unsigned Left shift
			4'b0110: result <= a >> b[4:0];		// Unsigned Right shift
			4'b0111: result <= a >>> b[4:0];	// Signed Right shift
			4'b1000: result <= (a == b) ? 1 : 0;						// Equal
			4'b1001: result <= (a < b) ? 1 : 0;							// Less Than Unsigned
			4'b1010: result <= (a_signed < b_signed) ? 1 : 0;			// Less Than Signed
			4'b1011: result <= (a >= b) ? 1 : 0;						// Greater Than or Equal Unsigned
			4'b1100: result <= (a_signed >= b_signed) ? 1 : 0;			// Greater Than or Equal Signed
			4'b1101: result <= (a_signed + b_signed) & 32'hFFFFFFFE;	// JARL		
			default: result <= 32'hXXXXXXXX;
		endcase
	end

endmodule




