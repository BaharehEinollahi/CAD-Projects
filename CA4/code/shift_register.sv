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

    genvar i;
    generate
        for (i = 0; i < 6; i = i + 1) begin : bits
            wire shift_source;
            assign shift_source = (i == 0) ? input_bit : data_out[i-1];

            s2 bit_reg (
                .D00(data_out[i]),    
                .D01(shift_source),    
                .D10(parallel_in[i]),   
                .D11(parallel_in[i]),  
                .A1(load), 
				.B1(1'b0),  
                .A0(shift), 
				.B0(1'b1), 
                .clr(rst),
                .clk(clk),
                .out(data_out[i])
            );
        end
    endgenerate

endmodule