`timescale 1ns/1ns

module hash_top(
    input clk,
    input rst,
    input start,
    input [127:0] parallel_in_m,
    output done,
    output out
);

    wire co_counter_i;
    wire done_rnd;

    wire inz_counter_i;
    wire en_counter_i;
    wire start_rnd;
    wire load_m;
    hash_ct hash_ct(
    .clk(clk),
    .rst(rst),
    .start(start),

    .co_counter_i(co_counter_i),
	.done_rnd(done_rnd),

    .inz_counter_i(inz_counter_i),
	.en_counter_i(en_counter_i),
	.start_rnd(start_rnd),
	.load_m(load_m),
	
	output logic load_a,
	output logic load_b,
	output logic load_c,
	output logic load_d,

	output logic sel_a1,
	output logic sel_b1,
	output logic sel_c1,
	output logic sel_d1,
	
	output logic sel_a2,
	output logic sel_b2,
	output logic sel_c2,
	output logic sel_d2,

	output logic load_f,
	output logic sel_f1,
	output logic sel_f2,

    output logic done
    );

    
 hash_dp hash_dp(
	input clk,
	input rst,
	input [127:0] parallel_in_m,
	
	input inz_counter_i,
	input en_counter_i,
	input start_rnd,
	input load_m,
	
	input load_a,
	input load_b,
	input load_c,
	input load_d,

	input sel_a1,
	input sel_b1,
	input sel_c1,
	input sel_d1,
	
	input sel_a2,
	input sel_b2,
	input sel_c2,
	input sel_d2,

	input load_f,
	input sel_f1,
	input sel_f2,

	output co_counter_i,
	output done_rnd,
    output out
    );



endmodule
