module SISO_ShiftRegister(
    input clk,rst,
    input serial_in,
    output reg serial_out);
    reg [3:0] shift_reg;
    
    always @(posedge clk or posedge rst) 
    begin
        if (rst)
            shift_reg <= 4'b0000;
        else begin
            shift_reg <= {shift_reg[2:0], serial_in};
            serial_out <= shift_reg[3];
        end
    end
endmodule