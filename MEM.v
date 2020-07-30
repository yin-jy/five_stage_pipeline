
`include "DEFINE.v"
module MEM(
    input wire rst,
    input wire clk,
    //from ex
    input wire [`REG_ADDR_BUS] waddr_i,
    input wire we_i,
    input wire [`REG_BUS] wdata_i,
    input wire mre_i,
    input wire mwe_i,
    input wire [`MEM_BUS] mwdata_i,
    input wire [`MEM_ADDR_BUS] maddr_i,
    //from datamemory
    input wire [`MEM_BUS] mrdata_i,
    //from peripheralcontrol
    input wire [`MEM_BUS] prdata_i,
    //to wb
    output wire [`REG_ADDR_BUS] waddr_o,
    output wire we_o,
    output wire [`REG_BUS] wdata_o,
    //to datamemory
    output wire mre_o,
    output wire mwe_o,
    //to peripheralcontrol
    output wire pre_o,
    output wire pwe_o,
    //to datamemory and peripheralcontrol
    output wire [`MEM_ADDR_BUS] mpaddr_o,
    output wire [`MEM_BUS] mpwdata_o
);

    assign waddr_o=(rst==`RST_ENABLE)?`NOP_REG_ADDR:waddr_i;
    assign we_o=(rst==`RST_ENABLE)?`WR_DISABLE:we_i;
    assign wdata_o= (rst==`RST_ENABLE)?`ZERO_WORD:
                    (mre_o==`RD_ENABLE)?mrdata_i:
                    (pre_o==`RD_ENABLE)?prdata_i:wdata_i;

    assign mre_o=   (rst==`RST_ENABLE)?`RD_DISABLE:
                    (mre_i==`RD_DISABLE)?`RD_DISABLE:
                    (maddr_i[30]==1'b0)?`RD_ENABLE:`RD_DISABLE;
    assign mwe_o=   (rst==`RST_ENABLE)?`WR_DISABLE:
                    (mwe_i==`WR_DISABLE)?`WR_DISABLE:
                    (maddr_i[30]==1'b0)?`WR_ENABLE:`WR_DISABLE;

    assign pre_o=   (rst==`RST_ENABLE)?`RD_DISABLE:
                    (mre_i==`RD_DISABLE)?`RD_DISABLE:
                    (maddr_i[30]==1'b1)?`RD_ENABLE:`RD_DISABLE;
    assign pwe_o=   (rst==`RST_ENABLE)?`WR_DISABLE:
                    (mwe_i==`WR_DISABLE)?`WR_DISABLE:
                    (maddr_i[30]==1'b1)?`WR_ENABLE:`WR_DISABLE;
     
    assign mpwdata_o=   (rst==`RST_ENABLE)?`ZERO_WORD:
                        (mwe_i==`WR_ENABLE)?mwdata_i:`ZERO_WORD;
    assign mpaddr_o=(rst==`RST_ENABLE)?`ZERO_WORD:
                    (mre_i|mwe_i)?maddr_i:`ZERO_WORD;

endmodule