
//
//	extend_tb.v
//		Immediate Extension Testbentch
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/10/2022
// -------------------------------- //
//	Last Modified: 10/10/2022

// Change Log:	NA

module extend_tb();
	reg [2:0]		ImmSrc;
	reg [31:0]		Instruction;
	wire [31:0]		ExtImm;


	extend UUT(
		.ImmSrc(ImmSrc),
		.Instr(Instruction[31:7]),
		.ExtImm(ExtImm)
		);

	initial begin
		ImmSrc <= 3'b000;
		Instruction <= 32'h0FF00FF0;
		#2
		ImmSrc <= 3'b001;
		Instruction <= 32'hFFFFFF80;
		#2
		$finish;
	end

endmodule
