`timescale 1ns/1ns

module hash_dp
(
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
	output [127:0] out
);

	wire [5:0] out_counter_i;
	counter counter_i #(6)(
		.clk(clk),
		.rst(rst),
		.inz(inz_counter_i),
		.en(en_counter_i),
		.inz_value(0),
		.cout(co_counter_i),
		.out(out_counter_i)
	);
	wire [1:0] rnd_out;
	rnd_generator_top(
		.clk(clk),
	    .rst(rst),
	    .start_rnd(start_rnd),
	    .parallel_in(out_counter_i),
	    .rnd_out(rnd_out),
	    .done_rnd(done_rnd)
	);
	wire [31:0] parallel_in_a;
	wire [31:0] parallel_in_b;
	wire [31:0] parallel_in_c;
	wire [31:0] parallel_in_d;

	wire [31:0] out_a;
	wire [31:0] out_b;
	wire [31:0] out_c;
	wire [31:0] out_d;

	wire [31:0] a0;
	wire [31:0] b0;
	wire [31:0] c0;
	wire [31:0] d0;

	assign a0 = 0x67452301;
	assign b0 = 0xefcdab89;
	assign a0 = 0x98badcfe;
	assign a0 = 0x10325476;


	assign parallel_in_a = (sel_a1) ? a0 : (sel_a2) out_d : 0;
	assign parallel_in_b = (sel_b1) ? b0 : (sel_b2) outb + barrel_shifter_out : 0!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!;
	assign parallel_in_c = (sel_c1) ? c0 : (sel_c2) out_b : 0;
	assign parallel_in_d = (sel_d1) ? d0 : (sel_d2) out_c : 0;
	register reg_a #(32)(
		.clk(clk),
		.rst(rst),
		.load(load_a),
		.parallel_in(parallel_in_a),
		.data_out(out_a)
	);

	register reg_b #(32)(
		.clk(clk),
		.rst(rst),
		.load(load_a),
		.parallel_in(parallel_in_a),
		.data_out(out_a)
	);

	register reg_c #(32)(
		.clk(clk),
		.rst(rst),
		.load(load_a),
		.parallel_in(parallel_in_a),
		.data_out(out_a)
	);

	register reg_d #(32)(
		.clk(clk),
		.rst(rst),
		.load(load_a),
		.parallel_in(parallel_in_a),
		.data_out(out_a)
	);

	wire [31:0] input_f1, input_f2;
	wire [31:0] out_f;
	assign input_f1 =  (out_counter_i[5:4] == 2'b00) ? ((out_b & out_c) | ((~out_b) & out_d)) :
							(out_counter_i[5:4] == 2'b01) ? ((out_d & out_b) | ((~out_d) & out_c)) :
							(out_counter_i[5:4] == 2'b10) ? (out_b ^ out_c ^ out_d ) :
							                                (out_c ^ (out_b | (~out_d)));

	register reg_f #(32)(
		.clk(clk),
		.rst(rst),
		.load(load_f),
		.parallel_in(parallel_in_f),
		.data_out(out_f)
	);

	wire [127:0] out_m;
	register reg_m #(128)(
		.clk(clk),
		.rst(rst),
		.load(load_m),
		.parallel_in(parallel_in_m),
		.data_out(out_m)
	);

	wire [31:0] m_rnd_;
	assign m_rnd_ =       (rnd_out == 2'b00) ? m[31:0]   :
                          (rnd_out == 2'b01) ? m[63:32]  :
                          (rnd_out == 2'b10) ? m[95:64]  :
                          (rnd_out == 2'b11) ? m[127:96] :
                          32'b0;
	
	wire [4:0] step_i_;
	rotate rotate(
		._i_(out_counter_i),
    	.step_i_(step_i_)
	)

	wire [31:0] constant_rom_out;
	constant_rom constant_rom(
		.addr(out_counter_i),
		.data(constant_rom_out)
	)


	wire [31:0] barrel_shifter_out;
	barrel_shifter barrel_shifter (
		.value(out_f),
		.shift_amount(step_i_),
		.out(barrel_shifter_out)
	)

	assign input_f2 = (constant_rom_out + out_f) + (m_rnd_ + out_a);
	assign parallel_in_f = (sel_f1) ?  input_f1 : (sel_f2) ? input_f2 : 0;   


	assign out = {out_a, out_b, out_c, out_d};
	
endmodule