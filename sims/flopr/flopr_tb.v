
//
//	flopr_tb.v
//		Resetable flip-flop
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 10/16/2022
// -------------------------------- //
//	Last Modified: 10/16/2022

// Change Log:	NA

module flopr_tb();
	parameter WIDTH = 32;

	reg 				reset = 0, clk = 0;
	reg [WIDTH:0]		d = 0;
	wire [WIDTH:0]		q;
	
	always begin
		#10
		clk <= ~clk;
	end
	
	
	flopr UUT(
		.d(d),
		.q(q),
		.clk(clk),
		.reset(reset)
		);

	initial begin
		d <= 127;
		
		#20
		
		d <= 255;
		
		#20
		
		reset <= 1;
		
		#30
		
		reset <= 0;
		
		#20
		
		$finish;
	end

endmodule
