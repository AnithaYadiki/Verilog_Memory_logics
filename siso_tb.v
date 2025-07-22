module tb_SISO_ShiftRegister;
    reg clk;
    reg rst;
    reg serial_in;
    wire serial_out;
    
    SISO_ShiftRegister DUT (.clk(clk), .rst(rst),.serial_in(serial_in),.serial_out(serial_out));
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    
    initial begin
        // Initialize
        rst = 1;
        serial_in = 0;
        #10 rst = 0; 
        
        // serial input
        #10 serial_in = 1;
        #10 serial_in = 0;
        #10 serial_in = 1;
        #10 serial_in = 1;
        #40; 
        
        
    end
endmodule