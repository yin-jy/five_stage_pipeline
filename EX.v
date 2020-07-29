
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
    wire [`REG_BUS] shiftout;
    //calculate according to aluop
    assign logicout=(rst==`RST_ENABLE)?`ZERO_WORD:
                    (aluop_i==`ALUOP_AND)?rdata1_i&rdata2_i:
                    (aluop_i==`ALUOP_OR)?rdata1_i|rdata2_i:
                    (aluop_i==`ALUOP_XOR)?rdata1_i^rdata2_i:
                    (aluop_i==`ALUOP_NOR)?~(rdata1_i|rdata2_i):`ZERO_WORD;
    
    assign shiftout=(rst==`RST_ENABLE)?`ZERO_WORD:
                    (aluop_i==`ALUOP_SLL)?rdata2_i<<rdata1_i[4:0]:
                    (aluop_i==`ALUOP_SRL)?rdata2_i>>rdata1_i[4:0]:
                    (aluop_i==`ALUOP_SRA)?({32{rdata2_i[31]}}<<(6'd32-{1'b0,rdata1_i[4:0]}))|(rdata2_i>>rdata1_i[4:0]):`ZERO_WORD;    
    //select final result according to alusel
    assign waddr_o=waddr_i;
    assign we_o=we_i;
    assign wdata_o= (alusel_i==`ALUSEL_LOGIC)?logicout:
                    (alusel_i==`ALUSEL_SHIFT)?shiftout:`ZERO_WORD;

endmodule