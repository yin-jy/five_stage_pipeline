
`include "DEFINE.v"
module EX(
    input wire rst,
    //from id_ex
    input wire [`ALUOP_BUS] aluop_i,
    input wire [`ALUSEL_BUS] alusel_i,
    input wire [`REG_BUS] rdata1_i,
    input wire [`REG_BUS] rdata2_i,
    input wire [`REG_ADDR_BUS] waddr_i,
    input wire we_i,
    //to ex_mem
    output wire [`REG_ADDR_BUS] waddr_o,
    output wire we_o,
    output wire [`REG_BUS] wdata_o
);

    wire [`REG_BUS] logicout;
    //calculate according to aluop
    assign logicout=(rst==`RST_ENABLE)?`ZERO_WORD:
                    (aluop_i==`ALUOP_OR)?rdata1_i|rdata2_i:`ZERO_WORD;
    //select final result according to alusel
    assign waddr_o=waddr_i;
    assign we_o=we_i;
    assign wdata_o=(alusel_i==`ALUSEL_LOGIC)?logicout:`ZERO_WORD;

endmodule