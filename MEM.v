
`include "DEFINE.v"
module MEM(
    input wire rst,
    input wire clk,
    //from ex
    input wire [`REG_ADDR_BUS] waddr_i,
    input wire we_i,
    input wire [`REG_BUS] wdata_i,
    //to wb
    output wire [`REG_ADDR_BUS] waddr_o,
    output wire we_o,
    output wire [`REG_BUS] wdata_o
);

    assign waddr_o=(rst==`RST_ENABLE)?`NOP_REG_ADDR:waddr_i;
    assign we_o=(rst==`RST_ENABLE)?`WR_DISABLE:we_i;
    assign wdata_o=(rst==`RST_ENABLE)?`ZERO_WORD:wdata_i;

endmodule