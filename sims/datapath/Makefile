

all:
	iverilog -o datapath_tb.out datapath_tb.v ../../*.v
	vvp datapath_tb.out
	gtkwave datapath_tb.vcd

clean:
	rm -f datapath_tb.out
	rm -f datapath_tb.vcd
