
//
//	extend.v
//		Immediate Extension
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/08/2022
// -------------------------------- //
//	Last Modified: 10/10/2022

// Change Log:	NA

module extend(Instr, ImmSrc, ExtImm)
	input wire [1:0]	ImmSrc;
	input wire [24:0]	Instr;
	output reg [31:0]	ExtImm;
	
	
	always @(ImmSrc, Instr) begin
		case (ImmSrc)
			2'b00:	
			default:ExtImm <= 32'h00000000;
		endcase
	end

endmodule
