


all:
	iverilog -o flopr_tb.out flopr_tb.v ../../flopr.v
	vvp flopr_tb.out
	gtkwave flopr_tb.vcd

clean:
	rm -f flopr_tb.out
	rm -f flopr_tb.vcd