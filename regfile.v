
//
//	regfile.v
//		Register file for the RV32I
//
//	By: Bryce Keen	
//	Created: 09/29/2022
//	Last Modified: 09/29/2022
//

module regfile(rs1, rs2, wrs3, rd, we, clk, reset, rdout1, rdout2);
	input wire 				clk, we, reset;
	input wire [4:0]		rs1, rs2, rd;
	input wire [31:0]		wrs3;
	output wire [31:0]		rdout1, rdout2;
	
	reg [31:0] x [31:0];
	
	assign rdout1 = x[rs1];
	assign rdout2 = x[rs2];
	
	
	always @(posedge clk) begin
					// x0 is reserved
		if (we & (rd != 0) & ~reset) begin	// Write enable
			x[rd] <= wrs3;									// Store wrs3 to rd register
		end
	end
		
	integer i;
	always @(clk, reset, we, rs1, rs2, rd, wrs3) begin
		if (reset) begin
			for (i = 0; i < 32; i = i + 1) begin 
				x[i] <= 0;
			end
		end		
	end
	
	
endmodule




