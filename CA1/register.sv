`timescale 1ns/1ns

module register
#(parameter WIDTH = 6)
(
	input clk,
	input rst,
	input load,
	input [WIDTH-1:0] parallel_in,
	output logic [WIDTH-1:0] data_out
);

	always @(posedge clk, posedge rst) begin
		if (rst) begin
			data_out <= 0;
		end else if (load) begin
			data_out <= parallel_in;
		end
	end

endmodule