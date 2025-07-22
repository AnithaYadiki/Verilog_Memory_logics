module tb_clock_buffer();
   reg pclk;
   wire sclk;
   time t1,t2,t3,t4,t5,t6;

   clk_buff DUT(.mclk(pclk),
                .bclk(sclk));
   
  always #10 pclk=~pclk;
  
  task initialize;
       begin
	     pclk=1'b0;
		end
	endtask
	
  task phase_pclk;
     begin
	   @(negedge pclk);
	    t1=$time;
	   @(negedge pclk);
	    t2=$time;
		t3=t2-t1;
	  end
	endtask
	
	task phase_sclk;
     begin
	   @(negedge sclk);
	    t4=$time;
	   @(negedge sclk);
	    t5=$time;
		t6=t5-t4;
	  end
	endtask
initial 
    begin
	    initialize;
		phase_pclk;
		phase_sclk;
		if(t2==t4)
		  $display("Both the clock are in phase");
		else
		  $display("clock are not in phase");
		if(t3==t6)
		  $display("both the clock periods are same");
		else
		  $display("clock periods are different");
    end		
endmodule	
	
	   