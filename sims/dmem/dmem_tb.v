
//
//	dmem_tb.v
//		Data Memory Testbentch
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/08/2022
// -------------------------------- //
//	Last Modified: 11/01/2022

// Change Log:	NA



module dmem_tb();
	reg 			we = 0, reset = 0;
	reg [2:0]		mode = 0;
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
		.we(we),
		.mode(mode),
		.reset(reset)
		);
		
	initial begin
		we <= 1;
		a <= 4;
		wd <= 32'hF00AA00F;
		
		#4
		we <= 0;
		a <= 4;
		
		#4
		we <= 1;
		a <= 5;
		mode <= 3'b001;
		wd <= 32'hFFFFFFFF;
		
		#4
		we <= 1;
		a <= 5;
		mode <= 3'b101;
		wd <= 32'hFFFFFFFF;
		
		#4
		we <= 1;
		a <= 10;
		mode <= 3'b010;
		wd <= 32'h000000AA;

		#4
		we <= 1;
		a <= 11;
		mode <= 3'b010;
		wd <= 32'h000000BB;
		
		#4
		we <= 1;
		a <= 12;
		mode <= 3'b010;
		wd <= 32'h0000BBAA;
		
		#4
		reset <= 1'b1;
		a <= 8;
		
		#4
		$finish;
	end
	
endmodule