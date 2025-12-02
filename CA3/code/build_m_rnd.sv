module build_m_rnd (
    input [31:0] out_m,
    input [1:0]  rnd_out,
    output [7:0] m_rnd_
);
genvar k;
generate
    for (k = 0; k < 8; k = k + 1) begin : mux_gen
        c1 c13(.A0(out_m[31-k]) , .A1(out_m[23-k]) , .SA(rnd_out[0]) , .B0(out_m[15-k]) , .B1(out_m[7-k]) , .SB(rnd_out[0]) , .S0(rnd_out[1]) , .S1(rnd_out[1]),.f(m_rnd_[7-k])) ;

    end
endgenerate

endmodule