
//
//	alu32_tb.v
//		Testbench for Register file for the RV32I
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 09/29/2022
// -------------------------------- //
//	Last Modified: 09/30/2022

// Change Log:	NA



module alu32_tb();
	reg [31:0]		a = 0, b = 0;
	reg [2:0]		ALUControl = 3'b000;
	wire [31:0]		result;
	
	alu32 UUT(
		.a(a),
		.b(b),
		.ALUControl(ALUControl),
		.result(result));
		
	initial begin
		ALUControl <= 3'b000;
		a <= 10;
		b <= 10;
		
		#2
		
		ALUControl <= 3'b001;
		a <= 10;
		b <= 10;
		
		#2
		
		ALUControl <= 3'b010;
		a <= 10;
		b <= 10;
				
		#2
		
		ALUControl <= 3'b011;
		a <= 10;
		b <= 10;
			
		#2
	
		ALUControl <= 3'b100;
		a <= 10;
		b <= 10;
			
		#2
	
		$finish;
	end
	
endmodule