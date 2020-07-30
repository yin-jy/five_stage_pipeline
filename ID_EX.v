
`include "DEFINE.v"
module ID_EX(
    input wire rst,
    input wire clk,
    //from id
    input wire [`ALUOP_BUS] id_aluop,
    input wire [`ALUSEL_BUS] id_alusel,
    input wire [`REG_BUS] id_rdata1,
    input wire [`REG_BUS] id_rdata2,
    input wire [`REG_ADDR_BUS] id_waddr,
    input wire id_we,
    input wire [`INST_ADDR_BUS] id_laddr,
    input wire id_mre,
    input wire id_mwe,
    input wire [`MEM_BUS] id_mwdata,
    //from ctrl
    input wire [`STALL_BUS] ctrl_stall,
    //to ex
    output reg [`ALUOP_BUS] ex_aluop,
    output reg [`ALUSEL_BUS] ex_alusel,
    output reg [`REG_BUS] ex_rdata1,
    output reg [`REG_BUS] ex_rdata2,
    output reg [`REG_ADDR_BUS] ex_waddr,
    output reg ex_we,
    output reg [`INST_ADDR_BUS] ex_laddr,
    output reg ex_mre,
    output reg ex_mwe,
    output reg [`MEM_BUS] ex_mwdata
);

    always @(posedge clk) begin
        if(rst==`RST_ENABLE) begin
            ex_aluop<=`ALUOP_NOP;
            ex_alusel<=`ALUSEL_NOP;
            ex_rdata1<=`ZERO_WORD;
            ex_rdata2<=`ZERO_WORD;
            ex_waddr<=`NOP_REG_ADDR;
            ex_we<=`WR_DISABLE;
            ex_laddr<=`ZERO_WORD;
            ex_mre<=`RD_DISABLE;
            ex_mwe<=`WR_DISABLE;
            ex_mwdata<=`ZERO_WORD;
        end else if((ctrl_stall[2]==`STALL_ENABLE)&&(ctrl_stall[3]==`STALL_DISABLE)) begin
            ex_aluop<=`ALUOP_NOP;
            ex_alusel<=`ALUSEL_NOP;
            ex_rdata1<=`ZERO_WORD;
            ex_rdata2<=`ZERO_WORD;
            ex_waddr<=`NOP_REG_ADDR;
            ex_we<=`WR_DISABLE;
            ex_laddr<=`ZERO_WORD;
            ex_mre<=`RD_DISABLE;
            ex_mwe<=`WR_DISABLE;
            ex_mwdata<=`ZERO_WORD;
        end else if(ctrl_stall[2]==`STALL_DISABLE) begin
            ex_aluop<=id_aluop;
            ex_alusel<=id_alusel;
            ex_rdata1<=id_rdata1;
            ex_rdata2<=id_rdata2;
            ex_waddr<=id_waddr;
            ex_we<=id_we;
            ex_laddr<=id_laddr;
            ex_mre<=id_mre;
            ex_mwe<=id_mwe;
            ex_mwdata<=id_mwdata;
        end else ;
    end

endmodule