
//
//	datapath.v
//		RV32I datapath
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 12/04/2022
// -------------------------------- //
//	Last Modified: 12/04/2022

// Change Log:	NA

module datapath(inst);
    input clk, reset;
    input regWE;
    input [31:0] inst;


    wire [31:0]     rdout1, rdout2, wrs3;

    regfile regFILE (
            .rs1(inst[19:15]),
            .rs2(inst[24:20]),
            .wrs3(wrs3),
            .rd(inst[11:7]),
            .we(regWE),
            .clk(clk),
            .reset(reset),
            .rdout1(rdout1),
            .rdout2(rdout2)
        );

    






endmodule





