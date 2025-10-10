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
	
	input clk,
	input rst,
	input load,
	input shift,
	input input_bit,
	input [5:0] parallel_in,
	wire [5:0] shregout;
	shift_register shreg(clk, rst, load, shift, shregout[5] ^ shregout[3] ^ shregout[1], parallel_in, shregout);
	assign rnd_out = shregout[5:4];
	
	
endmodule