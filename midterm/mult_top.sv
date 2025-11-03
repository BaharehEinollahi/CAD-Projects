module mult_top(
	input clk,
	input rst,
	
	input [7:0] initial_a,
	input [7:0] initial_w,
	
	input en_a,
	input en_w,
	input ctrl_a_in,
	
	output done,
	output [15:0] partial_sum
);

wire [7:0] parallel_a, out_a;
register a_reg(
	clk,
	rst,
	en_a,
	parallel_a,
	out_a
);

wire [7:0] out_w;
register w_reg(
	clk,
	rst,
	en_w,
	initial_w,
	out_w
);

wire [7:0] pe_out;
priority_encoder pe(
	out_a,
	pe_out
);
wire [2:0] encoder_out;
encoder encoder(
	pe_out,
	encoder_out
);
wire [15:0] shifted_res;
barrel_shifter bsh(
	out_w,
	encoder_out,
	shifted_res
);

assign done = &(~out_a);
assign partial_sum = done? 0 : shifted_res;
assign parallel_a = ctrl_a_in ? (out_a & ~(pe_out)) : initial_a;



endmodule