`timescale 1ns/1ns


module stripes_pe(
    input clk, 
    input rst,
    input [3:0]i_vec_a_bits,
    input [63:0]b,
    input [33:0]init_sum,
    input is_msb,
    input is_lsb,
    input valid,
    output [33:0]out
);
    wire [15:0] pe_out0, pe_out1, pe_out2, pe_out3;
    pe pe3(
        i_vec_a_bits[3],
        b[63:48],
        is_msb,
        pe_out3
    );
    
    pe pe2(
        i_vec_a_bits[2],
        b[47:32],
        is_msb,
        pe_out2
    );

    pe pe1(
        i_vec_a_bits[1],
        b[31:16],
        is_msb,
        pe_out1
    );

    pe pe0(
        i_vec_a_bits[0],
        b[15:0],
        is_msb,
        pe_out0
    );

    wire [33:0]input_sum_reg;
    assign input_sum_reg = {18'b0, pe_out0} + {18'b0, pe_out1} + {18'b0, pe_out2} + {18'b0, pe_out3} 
        + (is_msb? out << 1'b0 : 34'b0) + (is_lsb? init_sum : 0);
    register sum_reg(
        .clk(clk),
        .rst(rst),
        .in(input_sum_reg),
        .en(valid),
        .out(out)
    );







endmodule
