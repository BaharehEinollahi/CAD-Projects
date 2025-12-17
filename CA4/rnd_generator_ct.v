`timescale 1ns/1ns

module rnd_generator_ct
(
	input clk,
	input rst,
	input start_rnd,
	output reg shift_shreg,
	output reg load_shreg,
	output reg done_rnd
);
	reg inz_counter;
	reg en_counter;
	wire co_counter;
	counter counter(
		.clk(clk),
		.rst(rst),
		.inz(inz_counter),
		.en(en_counter),
		.inz_value(3'b010),
		.cout(co_counter)
	);

	parameter IDLE = 2'b00, A = 2'b01, B = 2'b10, C = 2'b11;
    reg [2:0] ps, ns;
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