
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
    input wire [`INST_ADDR_BUS] laddr_i,
    input wire mre_i,
    input wire mwe_i,
    input wire [`MEM_BUS] mwdata_i,
    //to ex_mem
    output wire [`REG_ADDR_BUS] waddr_o,
    output wire we_o,
    output wire [`REG_BUS] wdata_o,
    output wire mre_o,
    output wire mwe_o,
    output wire [`MEM_BUS] mwdata_o,
    output wire [`MEM_ADDR_BUS] maddr_o,
    //to ctrl
    output wire stallreq_o
);

    wire [`REG_BUS] rdata1_i_plus_rdata2_i;
    assign rdata1_i_plus_rdata2_i=rdata1_i+rdata2_i;

    wire [`REG_BUS] rdata1_i_minus_rdata2_i;
    assign rdata1_i_minus_rdata2_i=rdata1_i+~rdata2_i+32'h0000_0001;

    wire overflow;
    assign overflow=(aluop_i==`ALUOP_ADD)&&((rdata1_i[31]^~rdata2_i[31])&(rdata1_i[31]^rdata1_i_plus_rdata2_i[31]))?`OVERFLOW_ENABLE:
                    (aluop_i==`ALUOP_SUB)&&((rdata1_i[31]^rdata2_i[31])&(rdata1_i[31]^rdata1_i_minus_rdata2_i[31]))?`OVERFLOW_ENABLE:`OVERFLOW_DISABLE;

    wire [`REG_BUS] logicout;
    wire [`REG_BUS] shiftout;
    wire [`REG_BUS] arithmeticout;
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

    assign arithmeticout=   (rst==`RST_ENABLE)?`ZERO_WORD:
                            (aluop_i==`ALUOP_ADD)||(aluop_i==`ALUOP_ADDU)?rdata1_i_plus_rdata2_i:
                            (aluop_i==`ALUOP_SUB)||(aluop_i==`ALUOP_SUBU)?rdata1_i_minus_rdata2_i:
                            (aluop_i==`ALUOP_SLT)?{31'b0,(rdata1_i[31]&~rdata2_i[31])||((rdata1_i[31]^~rdata2_i[31])&rdata1_i_minus_rdata2_i[31])}:
                            (aluop_i==`ALUOP_SLTU)?{31'b0,rdata1_i<rdata2_i}:`ZERO_WORD;
    //select final result according to alusel
    assign waddr_o=(rst==`RST_ENABLE)?`NOP_REG_ADDR:waddr_i;
    assign we_o=(overflow==`OVERFLOW_DISABLE)?we_i:`WR_DISABLE;
    assign wdata_o= (alusel_i==`ALUSEL_LOGIC)?logicout:
                    (alusel_i==`ALUSEL_SHIFT)?shiftout:
                    (alusel_i==`ALUSEL_ARITHMETIC)?arithmeticout:
                    (alusel_i==`ALUSEL_LINK)?laddr_i:`ZERO_WORD;
    assign mre_o=   (rst==`RST_ENABLE)?`RD_DISABLE:
                    (mre_i^mwe_i)?mre_i:`RD_DISABLE;
    assign mwe_o=   (rst==`RST_ENABLE)?`WR_DISABLE:
                    (mre_i^mwe_i)?mwe_i:`WR_DISABLE;
    assign mwdata_o=(rst==`RST_ENABLE)?`ZERO_WORD:mwdata_i;
    assign maddr_o= (rst==`RST_ENABLE)?`ZERO_WORD:
                    (mre_i^mwe_i)?rdata1_i_plus_rdata2_i:`ZERO_WORD;

    assign stallreq_o=`STALLREQ_DISABLE;
endmodule