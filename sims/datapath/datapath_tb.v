

module datapath_tb();
    reg clk;
    reg reset;

    wire [31:0] pc, Instr, dmemAdrs, dmemData;

    //initial clk <= 0;
	always begin
		clk <= 0; 	
        #1;
        clk <= 1;
        #1;
	end

    imem instrMemory (
        .a(pc), 
        .rd(Instr));

    reg we;
    reg [2:0] mode;

    dmem dataMemory (
        .a(dmemAdrs), 
        .rd(dmemData), 
        .wd(ALUResults), 
        .clk(clk), 
        .we(we),                // Control Logic
        .mode(mode),            // Control Logic
        .reset(reset));

    reg         regWE, rs1sel, rs2sel;
    reg [1:0]   regsel, PCsel;
    reg [2:0]   ImmSel;
    reg [3:0]   ALUControl;
    wire [31:0] ALUResults;
    
    datapath UUT(
        .clk(clk), 
        .reset(reset), 
        .regWE(regWE),              // Control Logic
        .rs1sel(rs1sel),            // Control Logic
        .rs2sel(rs2sel),            // Control Logic
        .regsel(regsel),            // Control Logic
        .PCsel(PCsel),              // Control Logic
        .ImmSel(ImmSel),            // Control Logic
        .ALUControl(ALUControl),    // Control Logic
        .Instr(Instr),  
        .dmemData(dmemData), 
        .pc(pc), 
        .dmemAdrs(dmemAdrs),
        .ALUout(ALUResults));

    initial begin
        reset <= 1'b1;
        PCsel <= 2'b00;
        #3
        reset <= 1'b0;

        //mode <= 3'b000;
        we <= 1'b0;
        regWE <= 1'b1;
        //rs1sel <= 1'b0;
        //rs2sel <= 1'b0;
        regsel <= 2'b10;
        PCsel <= 2'b00;
        ImmSel <= 3'b000; 
        //ALUControl <= 4'b0000;
        #2;

        //mode <= 3'b000;
        we <= 1'b0;
        regWE <= 1'b1;
        rs1sel <= 1'b0;
        rs2sel <= 1'b1;
        regsel <= 2'b01;
        PCsel <= 2'b00;
        ImmSel <= 3'b011; 
        ALUControl <= 4'b0000;
        #2;
        $finish;
    end
     
    integer idx;
	initial begin
		$dumpfile("datapath_tb.vcd");
		//$dumpvars(0, datapath_tb);
        $dumpvars(0, datapath_tb);
        for (idx = 0; idx < 32; idx = idx + 1) begin
            $dumpvars(0, UUT.regFILE.x[idx]);
        end
        
	end

endmodule

