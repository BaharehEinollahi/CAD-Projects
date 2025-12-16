`timescale 1ns/1ns

module hash_top(
    input clk,
    input rst,
    input start,
    input [31:0] parallel_in_m,
    output done,
    output [31:0] out
);

    wire co_counter_i;
    wire done_rnd;

    wire inz_counter_i;
    wire en_counter_i;
    wire start_rnd;
    wire load_m;

    wire load_a;
    wire load_b;
    wire load_c;
    wire load_d;

    wire sel_a1;
    wire sel_b1;
    wire sel_c1;
    wire sel_d1;

    wire sel_a2;
    wire sel_b2;
    wire sel_c2;
    wire sel_d2;

    wire load_f;
    wire sel_f1;
    wire sel_f2;

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
	
	.load_a(load_a),
	.load_b(load_b),
	.load_c(load_c),
	.load_d(load_d),
	.sel_a1(sel_a1),
	.sel_b1(sel_b1),
	.sel_c1(sel_c1),
	.sel_d1(sel_d1),
	.sel_a2(sel_a2),
	.sel_b2(sel_b2),
	.sel_c2(sel_c2),
	.sel_d2(sel_d2),
	.load_f(load_f),
	.sel_f1(sel_f1),
	.sel_f2(sel_f2),

    .done(done)
    );

    
 hash_dp hash_dp(
	.clk(clk),
	.rst(rst),
	.parallel_in_m(parallel_in_m),
	.inz_counter_i(inz_counter_i),
	.en_counter_i(en_counter_i),
	.start_rnd(start_rnd),
	.load_m(load_m),
	.load_a(load_a),
	.load_b(load_b),
	.load_c(load_c),
	.load_d(load_d),
	.sel_a1(sel_a1),
	.sel_b1(sel_b1),
	.sel_c1(sel_c1),
	.sel_d1(sel_d1),
	.sel_a2(sel_a2),
	.sel_b2(sel_b2),
	.sel_c2(sel_c2),
	.sel_d2(sel_d2),
	.load_f(load_f),
	.sel_f1(sel_f1),
	.sel_f2(sel_f2),
	.co_counter_i(co_counter_i),
	.done_rnd(done_rnd),
    .out(out)
    );



endmodule
