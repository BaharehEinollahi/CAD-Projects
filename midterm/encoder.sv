module encoder(
	input [7:0] in;
	output [2:0] out;
);
    assign out_encoded[2] = in[7] | in[6] | in[5] | in[4];
    assign out_encoded[1] = in[7] | in[6] |  in[3] | in[2];
    assign out_encoded[0] = in[7] | in[5] | in[3] | in[1];
    
endmodule