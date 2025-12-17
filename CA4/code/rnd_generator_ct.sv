`timescale 1ns/1ns

module rnd_generator_ct
(
	input clk,
	input rst,
	input start_rnd,
	output logic shift_shreg,
	output logic load_shreg,
	output logic done_rnd
);
	logic inz_counter;
	logic en_counter;
	wire co_counter;
	counter counter(
		.clk(clk),
		.rst(rst),
		.inz(inz_counter),
		.en(en_counter),
		.inz_value(3'b010),
		.cout(co_counter)
	);
	
	typedef enum logic [1:0] {IDLE, A, B, C} state_t;
    state_t ps, ns;
	always@(posedge clk, posedge rst) begin
		if(rst) begin
			ps <= IDLE;
		end else begin
			ps <= ns;
		end
	end
	
	always@(*) begin
		case(ps)
			IDLE: begin
				if(start_rnd) begin
					ns = A;
				end else begin
					ns = IDLE;
				end
			end
			A: ns = B;
			B: begin
				if(co_counter) begin
					ns = C;
				end else begin
					ns = B;
				end
			end
			C: ns = IDLE;
			default: ns = IDLE;
		endcase
	end
	
	always@(*) begin
		load_shreg = 0;
		shift_shreg = 0;
		inz_counter = 0;
		en_counter = 0;
		done_rnd = 0;
		case(ps)
			IDLE:begin
			end
			A: begin
				load_shreg = 1;
				inz_counter = 1;
			end
			B: begin
				shift_shreg = 1;
				en_counter = 1;
			end
			C: begin
				done_rnd = 1;
			end
			default: begin
			end
		endcase
	end
	
	
endmodule