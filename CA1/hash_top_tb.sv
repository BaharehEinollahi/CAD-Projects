`timescale 1ns/1ns

module hash_top_tb;
    reg clk;
    reg rst;
    reg start;
    reg [127:0] parallel_in_m;
    wire done;
    wire [127:0] out;
    
    hash_top dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .parallel_in_m(parallel_in_m),
        .done(done),
        .out(out)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        parallel_in_m = 128'h0;
        
        #20;
        
        rst = 0;
        #20;
        
        parallel_in_m = 128'h41a801a8e81df62b14a661b85c97bf45;
        $display("Input data: %32h", parallel_in_m);
        
        start = 1;
        #10;
        start = 0;

        #100000;
        
        $stop;
    end
    
endmodule