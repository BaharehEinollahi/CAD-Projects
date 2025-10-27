`timescale 1ns/1ns

module pe(
	input serial_a,
	input [15:0]b,
	input is_msb,
	output [15:0]out
);
	wire [15:0]out_mux;
	assign out_mux = serial_a ? b: 16'b0;	
	assign out = is_msb ? out_mux : out_mux;
	
endmodule