
//
//	extend.v
//		Immediate Extension
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/08/2022
// -------------------------------- //
//	Last Modified: 10/11/2022

// Change Log:	NA

module extend(Instr, ImmSrc, ExtImm);
	input wire [2:0]	ImmSrc;
	input wire [24:0]	Instr;
	output reg [31:0]	ExtImm;
	
	
	always @(ImmSrc, Instr) begin
		case (ImmSrc)
			3'b000:	ExtImm <= {Instr[24:5], {12{1'b0}}};									// U-Type
			3'b001:	ExtImm <= {{21{Instr[24]}}, Instr[23:18], Instr[4:0]};					// S-Type
			3'b010:	ExtImm <= {{20{Instr[24]}}, Instr[0], Instr[23:18], Instr[4:1], 1'b0};	// B-Type
			3'b011:	ExtImm <= {{21{Instr[24]}}, Instr[23:13]};								// I-Type
			3'b100:	ExtImm <= {{13{Instr[24]}}, Instr[12:5], Instr[13], Instr[23:14], 1'b0};// J-Type
			default:ExtImm <= {32{1'b0}};
		endcase
	end

endmodule
