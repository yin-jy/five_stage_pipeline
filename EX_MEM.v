
`include "DEFINE.v"
module EX_MEM(
    input wire clk,
    input wire rst,
    //from ex
    input wire [`REG_ADDR_BUS] ex_waddr,
    input wire ex_we,
    input wire [`REG_BUS] ex_wdata,
    //to mem
    output reg [`REG_ADDR_BUS] mem_waddr,
    output reg mem_we,
    output reg [`REG_BUS] mem_wdata
);
    always @(posedge clk) begin
        if(rst==`RST_ENABLE) begin
            mem_waddr<=`NOP_REG_ADDR;
            mem_we<=`WR_DISABLE;
            mem_wdata<=`ZERO_WORD;
        end else begin
            mem_waddr<=ex_waddr;
            mem_we<=ex_we;
            mem_wdata<=ex_wdata;
        end
    end

endmodule