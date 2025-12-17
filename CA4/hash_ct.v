`timescale 1ns/1ns

module hash_ct(
	input clk,
	input rst,
	input start,

	input co_counter_i,
 	input done_rnd,

	output reg inz_counter_i,
	output reg en_counter_i,
	output reg start_rnd,
	output reg load_m,
	
	output reg load_a,
	output reg load_b,
	output reg load_c,
	output reg load_d,

	output reg sel_a1,
	output reg sel_b1,
	output reg sel_c1,
	output reg sel_d1,
	
	output reg sel_a2,
	output reg sel_b2,
	output reg sel_c2,
	output reg sel_d2,

	output reg load_f,
	output reg sel_f1,
	output reg sel_f2,

	output reg done
);

    // reg inz_counter_i, en_counter_i, start_rnd, load_m;
    // reg load_a, load_b, load_c, load_d;
    // reg sel_a1, sel_b1, sel_c1, sel_d1;
    // reg sel_a2, sel_b2, sel_c2, sel_d2;
    // reg load_f, sel_f1, sel_f2;
    // reg done;

	parameter IDLE = 3'b000, A = 3'b001, B = 3'b010, C = 3'b011, D = 3'b100, E = 3'b101, F = 3'b110, G = 3'b111;
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
				if(start) begin
					ns = A;
				end else begin
					ns = IDLE;
				end
			end
			A: ns = B;
			B: begin
				if(co_counter_i) begin
					ns = G;
				end else begin
					ns = C;
				end
			end
			C: ns = D;
			D:begin
				if(done_rnd) begin
					ns = E;
				end else begin
					ns = D;
				end
			end
			E: ns = F;
			F: ns = B;
			G: ns = IDLE;
			default: ns = IDLE;
		endcase
	end
	
	always@(*) begin
		inz_counter_i = 0;
        en_counter_i  = 0;
        start_rnd     = 0;
        load_m        = 0;

        load_a = 0;
        load_b = 0;
        load_c = 0;
        load_d = 0;

		sel_a1 = 0;
		sel_b1 = 0;
		sel_c1 = 0;
		sel_d1 = 0;
		
		sel_a2 = 0;
		sel_b2 = 0;
		sel_c2 = 0;
		sel_d2 = 0;

		load_f = 0;
		sel_f1 = 0;
		sel_f2 = 0;

		done = 0;
		case(ps)
			IDLE:begin
			end
			A: begin
				inz_counter_i = 1;
				load_m		= 1;
				load_a		= 1;
				load_b		= 1;
				load_c		= 1;
				load_d		= 1;

				sel_a1		= 1;
				sel_b1		= 1;
      			sel_c1		= 1;
				sel_d1		= 1;

			end
			B:begin end
			C: begin
				sel_f1		= 1;
				load_f		= 1;
				start_rnd 	= 1;
			end
			D: begin end
			E: begin
				load_f		= 1;
				sel_f2		= 1;
			end
			F: begin
				load_m		= 1;
				load_a		= 1;
				load_b		= 1;
				load_c		= 1;
				load_d		= 1;

				sel_a2		= 1;
				sel_b2		= 1;
				sel_c2		= 1;
				sel_d2		= 1;

				en_counter_i	= 1;
			end
			G: begin
				done 		    = 1;
			end
			default: begin
			end
		endcase
	end

endmodule