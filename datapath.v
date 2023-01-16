
//
//	datapath.v
//		RV32I datapath
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 12/04/2022
// -------------------------------- //
//	Last Modified: 01/16/2022

// Change Log:	NA

module datapath(inst);
    input clk, reset;

    input regWE;
    input [1:0] rs1sel, rs2sel, regsel, PCsel;
    input [2:0] ImmSel;
    input [3:0] ALUControl;
    input [31:0] inst;
    input [31:0] dmemData;

    output [31:0]   pc, dmemAdrs; 

    wire            PC_now, PC_next;
    wire [31:0]     rdout1, rdout2, wrs3;
    wire [31:0]     ExtImm, muxrs1, muxrs2;
    wire [31:0]     ALUResults;
    wire [31:0]     pcplus4, pcPlusImm;

    regfile regFILE (
        .rs1(inst[19:15]),
        .rs2(inst[24:20]),
        .wrs3(wrs3),
        .rd(inst[11:7]),
        .we(regWE),
        .clk(clk),
        .reset(reset),
        .rdout1(rdout1),
        .rdout2(rdout2));
    assign dmemAdrs <= rdout2;

    flopr #(.WIDTH(32)) pcREG (
        .d(PC_now), 
        .q(PC_next), 
        .clk(clk), 
        .reset(reset));
    assign pc <= PC_next;

    extend extendImm(
        .Instr(inst[31:7]), 
        .ImmSrc(ImmSel), 
        .ExtImm(ExtImm));

    mux2 #(.WIDTH(32)) muxrs1 (
        .a(rdout1), 
        .b(PC_next), 
        .sel(rs1sel), 
        .y(muxrs1));

    mux2 #(.WIDTH(32)) muxrs2 (
        .a(rdout2), 
        .b(ExtImm), 
        .sel(rs2sel), 
        .y(muxrs2));

    alu32 alu (
        .a(muxrs1), 
        .b(muxrs2), 
        .ALUControl(ALUControl), 
        .result(ALUResults));

    adder #(.WIDTH(32)) plus4 (
        .a(4), 
        .b(PC_next), 
        .y(pcplus4));

    mux4 #(.WIDTH(32)) regmux (
        .a(dmemData),
        .b(ALUResults),
        .c(ExtImm),
        .d(pcplus4),
        .sel(regsel), 
        .y(wrs3));

    mux4 #(.WIDTH(32)) pcmux (
        .a(pcplus4),
        .b(ALUResults),
        .c(pcPlusImm),
        .d(32'hXXXXXXXX),
        .sel(PCsel), 
        .y(PC_now));

    adder #(.WIDTH(32)) adderImm (
        .a(PC_next), 
        .b(ExtImm), 
        .y(pcPlusImm));

endmodule





