`timescale 1ns/1ns

module shift_register
(
	input clk,
	input rst,
	input load,
	input shift,
	input input_bit,
	input [5:0] parallel_in,
	output logic [5:0] data_out
);

	always @(posedge clk, posedge rst) begin
		if (rst) begin
			data_out <= 0;
		end else if (load) begin
			data_out <= parallel_in;
		end else if (shift) begin
			data_out <= {data_out[4:0], input_bit};
		end
	end

endmodule