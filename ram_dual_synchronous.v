module ram_dual_port(clk,rst,waddr,raddr,we,re,data_in,data_out);
  input clk,rst,we,re;
  input [3:0] waddr,raddr;
  input [7:0] data_in;
  output  reg [7:0] data_out;
  integer i;
  reg [7:0] mem [15:0];
  
  
  always@(posedge clk)
     begin
	  if(rst)
	    begin
		  for(i=0;i<16;i=i+1)
		    mem[i]<=8'b0;
		end
	  else
	    begin
		  if(we)
		    mem[waddr]<=data_in;
		  else
		    mem[waddr]<=mem[waddr];
		  if(re)
		   data_out<=mem[raddr];
		  else
		    data_out<=data_out;
	    end 
	  end
endmodule
	  