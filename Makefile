all: testbench
 
.PHONY: vvp waveform clean
 
testbench: testbench.v
	iverilog -g2001 -o testbench testbench.v

testbench.vcd: testbench
	vvp testbench
 
vvp: testbench.vcd
 
waveform: testbench.vcd
	gtkwave testbench.vcd
 
clean::
	rm -f testbench testbench.vcd