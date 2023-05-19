

module top_tb();
    reg     clk, reset;

    always begin
        clk <= 0;
        #2;
        clk <= 1;
        #2;
    end

    Top DUT (.clk(clk), .reset(reset));

    initial begin
        reset <= 1;
        #4;
        reset <= 0;
        #220
        $finish;
    end

    integer i;
	initial begin
		$dumpfile("top_tb.vcd");
		$dumpvars(0, top_tb);
        //for (i = 0; i < 31; i = i + 1)
        //    $dumpvars(1, DUT.RV32I_Logic.Signle_Cycle_Datapath.regFILE.x[i]);
        
        for (i = 0; i < 32; i = i + 1)
            $dumpvars(1, DUT.RV32I_Logic.Single_Cycle_Datapath.regFILE.x[i]);

	end
endmodule