`timescale 1ns/1ns

module counter
#(parameter WIDTH = 3)
(
	input clk,
	input rst,
	input inz,
	input en,
	input [WIDTH-1:0] inz_value,
	output  cout,
	output reg [WIDTH-1:0] out
);
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			out <= 0;
		end else if (inz) begin
			out <= inz_value;
		end else if (en) begin
			out <= out + 1;
		end
	end

	assign cout = out == ({WIDTH{1'b1}});

endmodule