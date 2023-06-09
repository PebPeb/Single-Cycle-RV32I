
//
//	Single_Cycle_RV32I.v
//		Single Cycle RV32I
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 01/25/2023
// -------------------------------- //
//	Last Modified: 01/25/2023

// Change Log:	NA

module Single_Cycle_RV32I(clk, reset, inst, pc, dmemWE, dmemMode, dmemAdrs, dmemDataRead, dmemDataStore);
    input wire          clk, reset;
    input wire [31:0]   inst, dmemDataRead;

    output wire [31:0]  dmemAdrs, dmemDataStore, pc;
    output wire [2:0]   dmemMode;
    output wire         dmemWE;

    wire [31:0]         ALUResults;
    wire [3:0]          ALUControl;
    wire [2:0]          immSEL;
    wire [1:0]          regSEL, pcSEL;
    wire                regWE, rs1SEL, rs2SEL;      

    datapath Single_Cycle_Datapath (
            .clk(clk), 
            .reset(reset), 
            .regWE(regWE), 
            .rs1sel(rs1SEL), 
            .rs2sel(rs2SEL), 
            .regsel(regSEL), 
            .PCsel(pcSEL), 
            .ImmSel(immSEL), 
            .ALUControl(ALUControl), 
            .Instr(inst),  
            .dmemData(dmemDataRead), 
            .pc(pc), 
            .dmemrs2(dmemDataStore), 
            .ALUout(ALUResults));
    assign dmemAdrs = ALUResults;

    control_logic Single_Cycle_Control (
            .clk(clk),
            .reset(reset),
            .inst(inst), 
            .jump(ALUResults[0]), 
            .ALUControl(ALUControl), 
            .dmemMode(dmemMode), 
            .immSEL(immSEL), 
            .regSEL(regSEL), 
            .pcSEL(pcSEL), 
            .dmemWE(dmemWE), 
            .regWE(regWE), 
            .rs1SEL(rs1SEL), 
            .rs2SEL(rs2SEL));



endmodule
