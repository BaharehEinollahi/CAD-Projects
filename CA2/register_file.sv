`timescale 1ns/1ns

module register_file(
    input clk,
    input rst,
    input load_rf,
    input [2:0] address,
    input [15:0] data_in,
    input [3:0] select,
    output [7:0] data_out
);

    wire [7:0] en_regs;
    decoder #(
        .IN_WIDTH(3)
    ) addr_decoder (
        .in(address),
        .en(load_rf),
        .out(en_regs)
    );

    wire [15:0] reg_outs [0:7];
    genvar i;
    generate
        for (i = 0; i < 8; i++) begin : reg_array
            reg_module #(
                .WIDTH(16)
                ) reg_inst (
                .clk(clk),
                .rst(rst),
                .data_in(data_in),
                .en(en_regs[i]),
                .data_out(reg_outs[i])
            );
        end
    endgenerate


   assign data_out = {
    reg_outs[0][select],
    reg_outs[1][select],
    reg_outs[2][select],
    reg_outs[3][select],
    reg_outs[4][select],
    reg_outs[5][select],
    reg_outs[6][select],
    reg_outs[7][select]
    };

endmodule