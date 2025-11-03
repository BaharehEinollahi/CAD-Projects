module vector_mult_ctrl(
    input clk,
    input rst,
    input start,
    input both_ready,
	
	output reg en_a0,
	output reg en_w0,
	output reg en_a1,
	output reg en_w1,
	
    output reg ctrl_a0_in,
    output reg ctrl_a1_in,
    output reg inz_acc,
    output reg ready
);

    typedef enum logic [2:0] {IDLE, INZ, PROCESS, READY } state_t;

    state_t ps, ns;
	
	always @(posedge clk, posedge rst) begin
		
	end
    always @(posedge clk or posedge rst) begin
        if (rst)
            ps <= IDLE;
        else
            ps <= ns;
    end

    always @(*) begin
        case (ps)
            IDLE: begin
                if (start)
                    ns = INIT;
				else
					ns = IDLE;
            end

            INIT: begin
                ns = PROCESS;
            end

            PROCESS: begin
                if (both_ready)
                    ns = READY;
				else
					ns = PROCESS;
            end

            READY: begin
                ns = IDLE;
            end
        endcase
    end
	
	
    always @(*) begin
        ctrl_a0_in = 0;
        ctrl_a1_in = 0;
        inz_acc = 0;
        done = 0;
	
		en_a0 = 0; 
		en_w0 = 0;
		en_a1 = 0;
		en_w1 = 0;
		
        case (ps)
            IDLE: begin
            end

            INIT: begin
                inz_acc = 1;
				en_a0 = 1; 
				en_w0 = 1;
				en_a1 = 1;
				en_w1 = 1;
				ctrl_a0_in = 0;
                ctrl_a1_in = 0;
            end

            PROCESS: begin
                ctrl_a0_in = 1;
                ctrl_a1_in = 1;
				en_a0 = 1;
				en_a1 = 1;
            end
			READY: begin
				ready = 1;
			end

        endcase
    end
endmodule
