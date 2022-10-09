
//
//	imem_tb.v
//		Instruction Memory Test bentch
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/08/2022
// -------------------------------- //
//	Last Modified: 10/08/2022

// Change Log:	NA



module imem_tb();
	reg [31:0]		a = 0;
	wire [31:0]		rd;
	
	imem UUT(
		.a(a),
		.rd(rd)
		);
		
	initial begin
		a <= 0;
		
		#2
		
		a <= 4;
		
		#2
		
		a <= 8;
		
		#2
		
		a <= 12;
		
		#2	
		
		a <= 16;
		
		#2
		
		a <= 20;
		
		#2	
		$finish;
	end
	
endmodule