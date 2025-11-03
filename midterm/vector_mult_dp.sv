module vector_mult_dp(
	input clk, 
	input rst,
	
	input [7:0] a0,
	input [7:0] w0,
	input [7:0] a1,
	input [7:0] w1,
	
	input en_a0,
	input en_w0,
	input en_a1,
	input en_w1,
		
	input ctrl_a0_in,
	input ctrl_a1_in,
	
	input inz_acc,
	output both_ready,
	output [15:0] result
	
);

wire done0, done1;
wire [15:0] mult0_out, mult1_out;
mult_top mult0(
	clk,
	rst,
	a0,
	w0,
	en_a0,
	en_w0,
	ctrl_a0_in,
	done0,
	mult0_out
);

mult_top mult1(
	clk,
	rst,
	a1,
	w1,
	en_a1,
	en_w1,
	ctrl_a1_in,
	done1,
	mult1_out
);	

assign both_ready = done0 & done1;
wire [15:0] sum_res;
assign sum_res = result + mult0_out + mult1_out;
register #(16) acc(
	clk,
	rst,
	1'b1,
	sum_res,
	result
);

endmodule


