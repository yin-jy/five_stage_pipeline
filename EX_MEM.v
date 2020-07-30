
`include "DEFINE.v"
module EX_MEM(
    input wire clk,
    input wire rst,
    //from ex
    input wire [`REG_ADDR_BUS] ex_waddr,
    input wire ex_we,
    input wire [`REG_BUS] ex_wdata,
    input wire ex_mre,
    input wire ex_mwe,
    input wire [`MEM_BUS] ex_mwdata,
    input wire [`MEM_ADDR_BUS] ex_maddr,
    //from ctrl
    input wire [`STALL_BUS] ctrl_stall,
    //to mem
    output reg [`REG_ADDR_BUS] mem_waddr,
    output reg mem_we,
    output reg [`REG_BUS] mem_wdata,
    output reg mem_mre,
    output reg mem_mwe,
    output reg [`MEM_BUS] mem_mwdata,
    output reg [`MEM_ADDR_BUS] mem_maddr
);
    always @(posedge clk) begin
        if(rst==`RST_ENABLE) begin
            mem_waddr<=`NOP_REG_ADDR;
            mem_we<=`WR_DISABLE;
            mem_wdata<=`ZERO_WORD;
            mem_mre<=`RD_DISABLE;
            mem_mwe<=`WR_DISABLE;
            mem_mwdata<=`ZERO_WORD;
            mem_maddr<=`ZERO_WORD;
        end else if((ctrl_stall[3]==`STALL_ENABLE)&&(ctrl_stall[4]==`STALL_DISABLE)) begin
            mem_waddr<=`NOP_REG_ADDR;
            mem_we<=`WR_DISABLE;
            mem_wdata<=`ZERO_WORD;
            mem_mre<=`RD_DISABLE;
            mem_mwe<=`WR_DISABLE;
            mem_mwdata<=`ZERO_WORD;
            mem_maddr<=`ZERO_WORD;
        end else if(ctrl_stall[3]==`STALL_DISABLE) begin
            mem_waddr<=ex_waddr;
            mem_we<=ex_we;
            mem_wdata<=ex_wdata;
            mem_mre<=ex_mre;
            mem_mwe<=ex_mwe;
            mem_mwdata<=ex_mwdata;
            mem_maddr<=ex_maddr;
        end else ;
    end

endmodule