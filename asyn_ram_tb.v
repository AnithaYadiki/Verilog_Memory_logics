module a_dual_port_ram_tb();
    reg wr_clk, rd_clk;
    reg [2:0] wr_addr, rd_addr;
    reg [15:0] wr_data;
    reg wr_en;
    wire [15:0] rd_data;

    // Instantiate the DUT (Device Under Test)
    a_dual_port_ram DUT (
        .wr_clk(wr_clk), .rd_clk(rd_clk),
        .wr_addr(wr_addr), .rd_addr(rd_addr),
        .wr_data(wr_data), .wr_en(wr_en),
        .rd_data(rd_data)
    );

    // Generate write clock (10 time units period)
    always #5 wr_clk = ~wr_clk;

    // Generate read clock (15 time units period, different from write clock)
    always #7.5 rd_clk = ~rd_clk;

    initial begin
        // Initialize signals
        wr_clk = 0; rd_clk = 0;
        wr_addr = 0; rd_addr = 0; wr_data = 0; wr_en = 0;

        // Write values into RAM
        #10 wr_en = 1; wr_addr = 3'b000; wr_data = 16'hA1A1;
        #10 wr_addr = 3'b001; wr_data = 16'hB2B2;
        #10 wr_addr = 3'b010; wr_data = 16'hC3C3;
        #10 wr_addr = 3'b011; wr_data = 16'hD4D4;
        #10 wr_addr = 3'b100; wr_data = 16'hE5E5;
        #10 wr_en = 0; // Stop writing

        // Read back values from RAM
        #20 rd_addr = 3'b000;
        #20 rd_addr = 3'b001;
        #20 rd_addr = 3'b010;
        #20 rd_addr = 3'b011;
        #20 rd_addr = 3'b100;

        // End simulation
        #50 $finish;
    end

    initial begin
        $monitor("Time=%0t, wr_en=%b, wr_addr=%b, wr_data=%h, rd_addr=%b, rd_data=%h", 
                 $time, wr_en, wr_addr, wr_data, rd_addr, rd_data);
    end

endmodule