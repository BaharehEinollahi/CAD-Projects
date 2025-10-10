`timescale 1ns/1ns

module counter
#parameter WIDTH = 3
(
	input clk,
	input rst,
	intput inz,
	input en,
	output logic cout
);
	logic [WIDTH-1:0] count;
	always @(posedge clk, posedge rst) begin
		if (!rst) begin
			count <= 0;
		end else if (inz) begin
			count <= 0;
		end else if (en) begin
			count <= count + 1;
		end
	end

	assign cout = (count == 4'b111) ? 1'b1 : 1'b0;

endmodule