
module fifo_router_tb;
    reg clock;
    reg reset;
    reg write_en;
    reg read_enable;
    reg soft_reset;
    reg lfd_state;
    reg [7:0] data_in;
    wire full;
    wire empty;
    wire [7:0] data_out;

    router_fifo DUT (clock,reset,data_in,write_en,read_enable,soft_reset,lfd_state,full,empty,data_out);
	
    always #5 clock = ~clock; 

    task reset_fifo;
        begin
		    @(negedge clock) begin
            reset = 1'b0;
            #10;
            reset = 1'b1;end
        end
    endtask

    task write;
        input [7:0] data;
        begin
		    @(negedge clock)
			begin
            write_en = 1;
            data_in = data;
            #10;
            write_en = 0;
            data_in = 8'b0;
            #10;
			end
        end
    endtask

    task read_fifo;
        begin
		    @(negedge clock)
			begin
            read_enable = 1;
            #10;
            read_enable = 0;
            #10;
			end
        end
    endtask

    task soft_reset_fifo;
        begin
		    @(negedge clock)
			begin
            soft_reset = 1;
            #10;
            soft_reset = 0;
            #10;
			end
        end
    endtask

    initial 
	    begin
            clock = 0;
            reset = 1;
            write_en = 0;
            read_enable = 1;
            soft_reset = 0;
            read_enable=1;
            lfd_state = 0;
            reset=0;
            data_in = 8'b0;
            reset_fifo;
            write(8'h01);
            write(8'h02);
            write(8'h03);
            write(8'h04);
            read_enable=1;
            read_fifo;
            read_fifo;
            soft_reset_fifo;
            write(8'h05);
            read_fifo;
            read_enable=1;
            write(8'h06);
            write(8'h07);
            write(8'h08);
            write_(8'h09);
            write(8'h0A);
            $stop;

 
        end
endmodule
      	   