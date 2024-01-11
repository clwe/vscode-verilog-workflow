 
/*
 * i shift in function. 
 * Slot size is 32 bit with 2 channels
 * data size can be changed with parameter N
 */
module i2s_rx2
	#(parameter N=32 ) // data size)
(
	input			nrst,		// Asynchronous reset
	output reg	[N-1:0]	chan0,		// Fifo interface, chan0
	output reg	[N-1:0]	chan1,		// Fifo interface, chan1

	input				sck,		// tdm bclk
	input				ws,			// tdm frame sync (word clock)
	input				sd			// Data in from i
);
	// generate slot pulse
	reg wsd = 0;
	reg wsdd = 0;
	always @(posedge sck ) begin
		wsd <= ws;
		wsdd <= wsd;
	end

	wire r = !wsd & wsdd;
	wire l = wsd & !wsdd;
	wire wsp = wsd != wsdd;

	always @(posedge sck ) begin
		if(l)
			chan0 <= shift;
		if(r)
			chan1 <= shift;
	end

	reg[5:0] count;
	always @(negedge sck ) begin
		if(wsp)
			count <= 0;
		else if(!count<32)
			count <= count +1;
	end

	// shift-register
	reg [0:N-1] shift;

	always @(posedge sck ) begin
		if (wsp) shift <= 0;
		if (count<N) shift[count] <= sd;
	end

endmodule