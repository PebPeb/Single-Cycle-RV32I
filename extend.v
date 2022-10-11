
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

module extend(Instr, ImmSrc, ExtImm);
	input wire [1:0]	ImmSrc;
	input wire [24:0]	Instr;
	output reg [31:0]	ExtImm;
	
	
	always @(ImmSrc, Instr) begin
		case (ImmSrc)
			2'b00:	ExtImm <= {Instr[24:5], 12'h000};						// U-Type
			2'b01:	ExtImm <= {Instr[24:18], Instr[4:0], 20'h00000} >>> 20;	// S-Type
			default:ExtImm <= 32'h00000000;
		endcase
	end

endmodule
