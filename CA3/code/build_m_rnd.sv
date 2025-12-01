module build_m_rnd (
    input [31:0] out_m,
    input [1:0]  rnd_out,
    output [7:0] m_rnd_
);
genvar k;
generate
    for (k = 0; k < 8; k = k + 1) begin : mux_gen
        c2 c2_inst (
            .D00(out_m[31-k]), 
            .D01(out_m[23-k]), 
            .D10(out_m[15-k]), 
            .D11(out_m[7-k]), 
            .A1(rnd_out[1]), 
            .B1(1'b0),   
            .A0(rnd_out[0]), 
            .B0(1'b1),    
            .out(m_rnd_[7-k])
        );
    end
endgenerate

endmodule