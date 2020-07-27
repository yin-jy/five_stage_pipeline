
`include "DEFINE.v"
module PC(
    input wire clk,
    input wire rst,
    output reg [`INST_ADDR_BUS] pc,
    output reg ce
);

    always @(posedge clk) begin
        if(rst==`RST_ENABLE) ce<=`CHIP_DISABLE;
        else ce<=`CHIP_ENABLE;
    end

    always @(posedge clk) begin
        if(ce==`CHIP_DISABLE) pc<=`ZERO_WORD;
        else pc<=pc+32'h0000_0004;
    end

endmodule