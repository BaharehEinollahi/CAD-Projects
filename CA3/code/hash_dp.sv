`timescale 1ns/1ns

module hash_dp
(
	input clk,
	input rst,
	input [31:0] parallel_in_m,

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
	output [31:0] out
);

	wire [5:0] out_counter_i;
	counter #(.WIDTH(6)) counter_i (
		.clk(clk),
		.rst(rst),
		.inz(inz_counter_i),
		.en(en_counter_i),
		.inz_value(0),
		.cout2(co_counter_i),
		.out(out_counter_i)
	);
	wire [1:0] rnd_out;
	rnd_generator_top rnd_generator_top(
		.clk(clk),
	    .rst(rst),
	    .start_rnd(start_rnd),
	    .parallel_in(out_counter_i),
	    .rnd_out(rnd_out),
	    .done_rnd(done_rnd)
	);
	wire [7:0] parallel_in_a;
	wire [7:0] parallel_in_b;
	wire [7:0] parallel_in_c;
	wire [7:0] parallel_in_d;

	wire [7:0] out_a;
	wire [7:0] out_b;
	wire [7:0] out_c;
	wire [7:0] out_d;

	wire [7:0] a0;
	wire [7:0] b0;
	wire [7:0] c0;
	wire [7:0] d0;

	assign a0 = 8'h01;
	assign b0 = 8'h89;
	assign c0 = 8'hfe;
	assign d0 = 8'h76;

	wire [7:0] multiplier_out;

	assign parallel_in_a = (sel_a1) ? a0 : (sel_a2)? out_d : 0;
	assign parallel_in_b = (sel_b1) ? b0 : (sel_b2)? out_b + multiplier_out : 0;
	assign parallel_in_c = (sel_c1) ? c0 : (sel_c2)? out_b : 0;
	assign parallel_in_d = (sel_d1) ? d0 : (sel_d2)? out_c : 0;
	register #(8) reg_a (
		.clk(clk),
		.rst(rst),
		.load(load_a),
		.parallel_in(parallel_in_a),
		.data_out(out_a)
	);

	register #(8) reg_b (
		.clk(clk),
		.rst(rst),
		.load(load_b),
		.parallel_in(parallel_in_b),
		.data_out(out_b)
	);

	register #(8) reg_c (
		.clk(clk),
		.rst(rst),
		.load(load_c),
		.parallel_in(parallel_in_c),
		.data_out(out_c)
	);

	register #(8) reg_d (
		.clk(clk),
		.rst(rst),
		.load(load_d),
		.parallel_in(parallel_in_d),
		.data_out(out_d)
	);

	wire [7:0] input_f1, input_f2, parallel_in_f;
	wire [7:0] out_f;
	assign input_f1 =  (out_counter_i[5:4] == 2'b00) ? ((out_b & out_c) | ((~out_b) & out_d)) :
							(out_counter_i[5:4] == 2'b01) ? ((out_d & out_b) | ((~out_d) & out_c)) :
							(out_counter_i[5:4] == 2'b10) ? (out_b ^ out_c ^ out_d ) :
							                                (out_c ^ (out_b | (~out_d)));

	register #(8) reg_f (
		.clk(clk),
		.rst(rst),
		.load(load_f),
		.parallel_in(parallel_in_f),
		.data_out(out_f)
	);

	wire [31:0] out_m;
	register #(32) reg_m (
		.clk(clk),
		.rst(rst),
		.load(load_m),
		.parallel_in(parallel_in_m),
		.data_out(out_m)
	);

	wire [7:0] m_rnd_;
	assign m_rnd_ =       (rnd_out == 2'b11) ? out_m[7:0]   :
                          (rnd_out == 2'b10) ? out_m[15:8]  :
                          (rnd_out == 2'b01) ? out_m[23:16]  :
                          (rnd_out == 2'b00) ? out_m[31:24] :
                          32'b0;
	

	wire [7:0] constant_rom_out;
	constant_rom constant_rom(
		.addr(out_counter_i),
		.data(constant_rom_out)
	);


	multiplier multiplier(
		out_f,
		multiplier_out
	);

	assign input_f2 = (constant_rom_out + out_f) + (m_rnd_ + out_a);
	assign parallel_in_f = (sel_f1) ?  input_f1 : (sel_f2) ? input_f2 : 0;   


	assign out = {out_a, out_b, out_c, out_d};
	
endmodule