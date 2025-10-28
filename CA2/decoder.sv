`timescale 1ns/1ns


module decoder #(
    parameter IN_WIDTH = 3
)(
    input  logic [IN_WIDTH-1:0] in,
    input  logic                en,
    output logic [2**IN_WIDTH-1:0] out
);

    always_comb begin
        if (en) begin
            out = '0;
            out[in] = 1'b1;
        end else begin
            out = '0;
        end
    end

endmodule