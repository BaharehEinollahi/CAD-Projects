`timescale 1ns/1ns

module matrix_multiplier_top_tb;
    reg clk;
    reg rst;
    reg start;
    wire done;

    matrix_multiplier_top dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        start = 0;

        #10;
        rst = 0;

        #10;
        start = 1;
        #10;
        start = 0;

        wait(done);
        #10;

        $stop(0);
    end

endmodule
