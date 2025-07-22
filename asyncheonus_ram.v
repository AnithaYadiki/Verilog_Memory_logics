module a_dual_port_ram (
    input wr_clk, rd_clk,           // Write and read clocks
    input [2:0] wr_addr, rd_addr,   // 3-bit addresses for 8 locations
    input [15:0] wr_data,           // 16-bit write data
    input wr_en,                    // Write enable
    output reg [15:0] rd_data       // 16-bit read data
);

    reg [15:0] mem [7:0]; // 16-bit memory with 8 locations

    // Write operation (synchronous with write clock)
    always @(posedge wr_clk) begin
        if (wr_en)
            mem[wr_addr] <= wr_data;
    end

    // Read operation (synchronous with read clock)
    always @(posedge rd_clk) begin
        rd_data <= mem[rd_addr];
    end

endmodule