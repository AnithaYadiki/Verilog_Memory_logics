module ram_dual_port_tb();
    reg clk,rst;
	reg [3:0] waddr,raddr;
	reg we,re;
	reg[7:0] data_in;
	wire [7:0] data_out;
	integer i;
	
ram_dual_port  DUT (clk,rst,waddr,raddr,we,re,data_in,data_out);
   
   task initialize;
     begin
	 {clk,rst,waddr,raddr,we,re}=0;
	 data_in=0;
	 end
	endtask
	task reset;
	  begin
	  @(negedge clk) rst=1'b1;
	   @(negedge clk) rst=1'b0;
	  end 
	 endtask 
	task write_data(input[3:0] write_addr, input[7:0] write_data);
	  begin
	  @(negedge clk);
	  we=1'b1;
	    waddr=write_addr;
		data_in=write_data;
	  end 
	endtask
task read_data;
	    input [3:0] read_addr;
		begin
		    @(negedge clk);
			re = 1'b1;
			raddr = read_addr;
		end
	endtask	
	always #10 clk = ~clk;
	    initial
		begin
		    initialize;
			 reset;
			 for(i=0; i<16 ; i= i+1)
			     begin
				     write_data (i,($random)%256);
					 read_data(i);
				 end	
		end
endmodule