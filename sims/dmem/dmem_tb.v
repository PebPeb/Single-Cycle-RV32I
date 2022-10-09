
//
//	dmem_tb.v
//		Data Memory Testbentch
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/08/2022
// -------------------------------- //
//	Last Modified: 10/08/2022

// Change Log:	NA



module dmem_tb();
	reg 			we = 0;
	reg [31:0]		a = 0, wd = 0;
	wire [31:0]		rd;
	
	reg 			clk = 0;
	always begin
		clk = ~clk; 	#1;
	end
	
	
	dmem UUT(
		.a(a),
		.rd(rd),
		.wd(wd),
		.clk(clk),
		.we(we)
		);
		
	initial begin
		we <= 1;
		a <= 4;
		wd <= 32'hF00AA00F;
		
		#4
		we <= 0;
		a <= 4;
		
		#4
		
		a <= 8;
		
		#4
		$finish;
	end
	
endmodule