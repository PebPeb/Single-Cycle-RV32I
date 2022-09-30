
//
//	regfile_tb.v
//		Testbench for Register file for the RV32I
//
//	By: Bryce Keen	Last Modified: 09/29/2022
//


module regfile_tb();
	reg 				clk = 0, we = 0, reset = 0;
	reg  [4:0]			rs1 = 0, rs2 = 0, rd = 0;
	reg  [31:0]			wrs3 = 0;
	wire  [31:0]		rdout1, rdout2;
	
	always begin				// Clock
		clk = ~clk;		#1;
	end
	
	
	regfile UUT(
		.rs1(rs1), 
		.rs2(rs2), 
		.wrs3(wrs3), 
		.rd(rd), 
		.we(we), 
		.clk(clk), 
		.reset(reset), 
		.rdout1(rdout1), 
		.rdout2(rdout2));
		
	initial begin
		#10
		rs1 = 1;
		rs2 = 2;
		rd = 3;
		#10
		wrs3 = 16;
		we = 1;
		#10
		we = 0;
		rs1 = 3;
		#10
		reset = 1;
		#10		
		$finish;
	end
	
endmodule