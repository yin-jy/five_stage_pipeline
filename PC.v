
`include "DEFINE.v"
module PC(
    input wire clk,
    input wire rst,
    input wire [`STALL_BUS] ctrl_stall,
    input wire be,
    input wire [`INST_ADDR_BUS] baddr,
    input wire ie,
    output reg [`INST_ADDR_BUS] pc,
    output reg ce
);

    always @(posedge clk) begin
        if(rst==`RST_ENABLE) ce<=`CHIP_DISABLE;
        else ce<=`CHIP_ENABLE;
    end

    always @(posedge clk) begin
        if(ce==`CHIP_DISABLE) pc<=`PC_RST_WORD;
        else if (ctrl_stall[0]==`STALL_DISABLE) begin
            if(ie==`TIMER_INT_STATUS) pc<=`PC_INT_WORD;
            else if(be==`BRANCH_ENABLE) pc<=baddr;
            else pc<={pc[31],(pc[30:0]+31'h0000_0004)};
        end
        else ;
    end

endmodule