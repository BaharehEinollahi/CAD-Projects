`timescale 1ns/1ns

module register_file #(
    parameter ADDR_WIDTH = 3,
    parameter DATA_WIDTH = 16,
    parameter N_REGS = 8,
    parameter SEL_WIDTH = $clog2(DATA_WIDTH)
)(
    input clk,
    input rst,
    input load_rf,
    input [ADDR_WIDTH-1:0] address,
    input [DATA_WIDTH-1:0] data_in,
    input [SEL_WIDTH-1:0] select,
    output [N_REGS-1:0] data_out
);

    wire [N_REGS-1:0] en_regs;
    decoder #(
        .IN_WIDTH(ADDR_WIDTH)
    ) addr_decoder (
        .in(address),
        .en(load_rf),
        .out(en_regs)
    );

    wire [DATA_WIDTH-1:0] reg_outs [0:N_REGS-1];
    genvar i;
    generate
        for (i = 0; i < N_REGS; i++) begin : reg_array
            register #(
                .WIDTH(DATA_WIDTH)
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
        reg_outs[0][DATA_WIDTH-1 - select],
        reg_outs[1][DATA_WIDTH-1 - select],
        reg_outs[2][DATA_WIDTH-1 - select],
        reg_outs[3][DATA_WIDTH-1 - select],
        reg_outs[4][DATA_WIDTH-1 - select],
        reg_outs[5][DATA_WIDTH-1 - select],
        reg_outs[6][DATA_WIDTH-1 - select],
        reg_outs[7][DATA_WIDTH-1 - select]
    };

endmodule