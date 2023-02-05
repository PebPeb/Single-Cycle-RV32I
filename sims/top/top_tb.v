

module top_tb();
    reg     clk, reset;

    always begin
        clk <= 0;
        #2;
        clk <= 1;
        #2;
    end

    Top UUT (.clk(clk), .reset(reset));

    initial begin
        reset <= 1;
        #4;
        reset <= 0;
        #12
        $finish;
    end

	initial begin
		$dumpfile("top_tb.vcd");
		$dumpvars(0, top_tb);
	end
endmodule