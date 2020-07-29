
`include "DEFINE.v"
module MEM_WB(
    input wire clk,
    input wire rst,
    //from mem
    input wire [`REG_ADDR_BUS] mem_waddr,
    input wire mem_we,
    input wire [`REG_BUS] mem_wdata,
    //from ctrl
    input wire [`STALL_BUS] ctrl_stall,
    //to wb
    output reg [`REG_ADDR_BUS] wb_waddr,
    output reg wb_we,
    output reg [`REG_BUS] wb_wdata
);

    always @(posedge clk) begin
        if(rst==`RST_ENABLE) begin
            wb_waddr<=`NOP_REG_ADDR;
            wb_we<=`WR_DISABLE;
            wb_wdata<=`ZERO_WORD;
        end else if((ctrl_stall[4]==`STALL_ENABLE)&&(ctrl_stall[5]==`STALL_DISABLE)) begin
            wb_waddr<=`NOP_REG_ADDR;
            wb_we<=`WR_DISABLE;
            wb_wdata<=`ZERO_WORD;            
        end else if(ctrl_stall[4]==`STALL_DISABLE) begin
            wb_waddr<=mem_waddr;
            wb_we<=mem_we;
            wb_wdata<=mem_wdata;
        end else ;
    end

endmodule