`timescale 1ns/1ns

module rnd_generator_top
(
	input clk,
	input rst,
	input start_rnd,
	input [5:0] parallel_in,
	output [1:0] rnd_out,
	output done_rnd
	
);

	wire shift_shreg;
	wire load_shreg;
	rnd_generator_ct ct(
		.clk(clk),
		.rst(rst),
		.start_rnd(start_rnd),
		.shift_shreg(shift_shreg),
		.load_shreg(load_shreg),
		.done_rnd(done_rnd)
	);
	
	rnd_generator_dp dp(
		.clk(clk),
		.rst(rst),
		.load(load_shreg),
		.shift(shift_shreg),
		.parallel_in(parallel_in),
		.rnd_out(rnd_out)
	);
	
	
endmodule