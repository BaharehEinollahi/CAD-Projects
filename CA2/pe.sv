`timescale 1ns/1ns

module pe #(
	parameter WIDTH = 16
)(
	input serial_a,
	input [WIDTH-1:0] b,
	input is_msb,
	output [WIDTH-1:0] out
);
	wire [WIDTH-1:0] out_mux;
	assign out_mux = serial_a ? b : {WIDTH{1'b0}};
	assign out = is_msb ? -out_mux : out_mux;
endmodule