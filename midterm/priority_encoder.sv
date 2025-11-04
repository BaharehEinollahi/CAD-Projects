module priority_encoder (
    input   [7:0] in,
    output  [7:0] out
);
    wire [7:0] en;
    assign en[7] = 1;
    assign en[6] = ~in[7] & en[7];
	assign en[5] = ~in[6] & en[6];
    assign en[4] = ~in[5] & en[5];
    assign en[3] = ~in[4] & en[4];
    assign en[2] = ~in[3] & en[3];
    assign en[1] = ~in[2] & en[2];
	assign en[0] = ~in[1] & en[1];
    
    assign out = in & en;
	
endmodule