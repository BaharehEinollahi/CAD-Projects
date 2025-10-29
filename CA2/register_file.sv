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
            register #(
                .WIDTH(16)
                ) reg_inst (
                .clk(clk),
                .rst(rst),
                .in(data_in),
                .en(en_regs[i]),
                .out(reg_outs[i])
            );
        end
    endgenerate


   assign data_out = {
    reg_outs[0][15 - select],
    reg_outs[1][15 - select],
    reg_outs[2][15 - select],
    reg_outs[3][15 - select],
    reg_outs[4][15 - select],
    reg_outs[5][15 - select],
    reg_outs[6][15 - select],
    reg_outs[7][15 - select]
    };

endmodule