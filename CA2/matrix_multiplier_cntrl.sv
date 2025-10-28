`timescale 1ns/1ns

module matrix_multiplier_cntrl(
    input clk,
    input rst,
    //start signal
    input start,
    //done signal
    input done,

    //counters in
    input co_row_counter,
    input co_pe_counter,
    input co_counter_k,
    //counters
    output en_row_counter,
    output inz_row_counter,
    output en_pe_counter,
    output inz_pe_counter,
    output en_counter_k,
    output inz_counter_k,
    //shift register
    output row_i_shift,
    //register file
    output load_rf,
    //pes
    output is_msb,
    output is_lsb,
    output is_valid,
    //memory 
    output write,
    output a_address,
    output b_address,
    output out_address
);

    typedef enum logic [2:0] {IDLE, WAIT, LOADA, ROWBEGIN, LOADROW, PE, WRTIEMEM, DONE} state_t;
    state_t ps, ns;

    always@(posedge clk, posedge rst) begin
		if(rst) begin
			ps <= IDLE;
		end else begin
			ps <= ns;
		end
	end
	
	always@(*) begin
		case(ps)
			IDLE: begin
				if(start) begin
					ns = WAIT;
				end else begin
					ns = IDLE;
				end
			end
			WAIT : begin
                if(!start) begin
                    ns = LOADA;
                end else begin
                    ns = WAIT;
                end
            end
            LOADA: begin
                if(co_counter_k) begin
                    ns = ROWBEGIN;
                end else begin
                    ns = LOADA;
                end
            ROWBEGIN: begin
                if(co_row_counter) begin
                    ns = LOADROW;
                end else begin
                    ns = DONE;
                end
            end
            LOADROW: begin
                if(co_counter_k) begin
                    ns = PE;
                end else begin
                    ns = LOADROW;
                end
            end
            PE: begin
                if(co_pe_counter) begin
                    ns = WRTIEMEM;
                end else begin
                    ns = PE;
                end
            end
            WRTIEMEM: begin
                ns = ROWBEGIN;
            end
            DONE: begin
                ns = IDLE;
            end 
			
		endcase
	end
	
	always@(*) begin
        load_rf = 0;
        row_i_shift = 0;
        en_row_counter = 0;
        inz_row_counter = 0;
        en_pe_counter = 0;
        inz_pe_counter = 0;
        en_counter_k = 0;
        inz_counter_k = 0;
        is_msb = 0;
        is_lsb = 0;
        is_valid = 0;
        write = 0;
        a_address = 0;
        b_address = 0;
        out_address = 0;
        done_rnd = 0;
		case(ps)
			WAIT: begin
                inz_counter_k = 1;
                inz_row_counter = 1;
            end
            LOADA: begin
                a_address = 1;
                load_rf = 1;
            end
            ROWBEGIN: begin
                en_row_counter = 1;
                if(co_row_counter) begin
                    inz_counter_k = 1;
                end
            end
            LOADROW: begin
                row_i_shift = 1;
                b_address = 1;
                if(co_counter_k) begin
                    is_valid = 1;
                    is_msb = 1;
                end
            end
            PE: begin
                is_valid = 1;
                if(co_pe_counter) begin
                    is_lsb = 1;
                end
                en_pe_counter = 1;
            end
            WRTIEMEM: begin
                out_address = 1;
                write = 1;
            end
            DONE: begin
                done = 1;
            end
		endcase
	end


endmodule