
`include "DEFINE.v"
module IF_ID(
    input wire clk,
    input wire rst,

    input wire [`INST_ADDR_BUS] if_pc,
    input wire [`INST_BUS] if_inst,

    output reg [`INST_ADDR_BUS] id_pc,
    output reg [`INST_BUS] id_inst
);

    always @(posedge clk) begin
        if(rst==`RST_ENABLE) begin
            id_pc<=`ZERO_WORD;
            id_inst<=`ZERO_WORD;
        end else begin
            id_pc<=if_pc;
            id_inst<=if_inst;        
        end
    end

endmodule