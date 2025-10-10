`timescale 1ns/1ns

module rnd_generator_dp
(
	input clk,
	input rst,
	input load,
	input shift,
	input [5:0] parallel_in,
	output [1:0] rnd_out
);

	wire [5:0] shregout;
	wire input_bit;
	assign input_bit = shregout[5] ^ shregout[3] ^ shregout[1];
	shift_register shreg(clk, rst, load, shift, input_bit, parallel_in, shregout);
	assign rnd_out = shregout[5:4];
	
	
endmodule