module priority_encoder (
    input   [7:0] in,
    output  [7:0] out,
);

    assign out[7] = in[7];
    assign out[6] = in[6] & ~out[7];
	assign out[5] = in[5] & ~out[6];
    assign out[4] = in[4] & ~out[5];
    assign out[3] = in[3] & ~out[4];
    assign out[2] = in[2] & ~out[3];
    assign out[1] = in[1] & ~out[2];
	assign out[0] = in[0] & ~out[1];
	
endmodule