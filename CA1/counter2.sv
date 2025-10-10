`timescale 1ns/1ns

module counter2
#(parameter WIDTH = 3)
(
	input clk,
	input rst,
	input inz,
	input en,
	input [WIDTH-1:0] inz_value,
	output logic cout,
	output logic [WIDTH-1:0] out
);
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			out <= 0;
			cout <= 0;
		end else if (inz) begin
			out <= inz_value;
			cout <= 0;
		end else if (en) begin
			{cout, out} <= out + 1;
		end
	end


endmodule