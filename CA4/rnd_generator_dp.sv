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


	wire shregout1_inv;
    logic_not not1(shregout[1], shregout1_inv);
    //b ^ c ^ d 
    c1 c13(.A0(shregout[1]) , .A1(shregout1_inv) , .SA(shregout[3]) , .B0(shregout1_inv) , .B1(shregout[1]) , .SB(shregout[3]) , .S0(shregout[5]) , .S1(shregout[5]),.f(input_bit)) ;

	shift_register shreg(clk, rst, load, shift, input_bit, parallel_in, shregout);
	assign rnd_out = shregout[5:4];
	
	
endmodule