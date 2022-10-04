

//
//	alu32.v
//		32 bit ALU for the RV32I implement
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/03/2022
// -------------------------------- //
//	Last Modified: 10/03/2022

// Change Log:	NA


module alu32(a, b, ALUControl, result);
	input wire [31:0]	a, b;
	input wire [2:0]	ALUControl;
	output reg [31:0]	result;


	always @(*) begin
		case (ALUControl)
			3'b000:	result <= a + b;
			3'b001:	result <= a - b;
			3'b010:	result <= a & b;
			3'b011:	result <= a | b;
			3'b100:	result <= a ^ b;
			3'b101:	result <= a << b;		// Unsigned Left shift
			3'b110:	result <= a >> b;		// Unsigned Right shift
			3'b111: result <= a >>> b;		// Signed Right shift
			default: result <= 32'hXXXXXXXX;
		endcase
	end

endmodule




