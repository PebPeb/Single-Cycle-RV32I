

all:
	iverilog -o top_tb.out top_tb.v ../../*.v
	vvp top_tb.out
	gtkwave top_tb.vcd

clean:
	rm -f top_tb.out
	rm -f top_tb.vcd
