
`include "DEFINE.v"
module ID(
    input wire rst,
    input wire [`INST_ADDR_BUS] pc_i,
    input wire [`INST_BUS] inst_i,
    //from regfile
    input wire [`REG_BUS] rdata1_i,
    input wire [`REG_BUS] rdata2_i,
    //to regfile
    output wire re1_o,
    output wire re2_o,
    output wire [`REG_ADDR_BUS] raddr1_o,
    output wire [`REG_ADDR_BUS] raddr2_o,
    //to id_ex
    output wire [`ALUOP_BUS] aluop_o,
    output wire [`ALUSEL_BUS] alusel_o,
    output wire [`REG_BUS] rdata1_o,
    output wire [`REG_BUS] rdata2_o,
    output wire [`REG_ADDR_BUS] waddr_o,
    output wire we_o
);

    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] funct;
    wire [15:0] imm;
    wire [31:0] immext;
    wire [25:0] target;

    assign opcode=inst_i[31:26];
    assign rs=inst_i[25:21];
    assign rt=inst_i[20:16];
    assign rd=inst_i[15:11];
    assign shamt=inst_i[10:6];
    assign funct=inst_i[5:0];
    assign imm=inst_i[15:0];
	assign immext = {((opcode==`OPCODE_ORI)||(opcode==`OPCODE_ANDI))?16'h0000:{16{imm[15]}},imm};
    assign target=inst_i[25:0];
    //to regfile
    assign re1_o=   (rst==`RST_ENABLE)?`RD_DISABLE:
                    ((opcode==`OPCODE_J)||(opcode==`OPCODE_JAL))?`RD_DISABLE:`RD_ENABLE;
    assign re2_o=   (rst==`RST_ENABLE)?`RD_DISABLE:
                    (opcode==`OPCODE_NOP)?`RD_ENABLE:`RD_DISABLE;
    assign raddr1_o=(rst==`RST_ENABLE)?`NOP_REG_ADDR:rs;
    assign raddr2_o=(rst==`RST_ENABLE)?`NOP_REG_ADDR:rt;
    //to id_ex
    assign aluop_o= (rst==`RST_ENABLE)?`ALUOP_NOP:
                    (opcode==`OPCODE_ORI)?`ALUOP_OR:`ALUOP_NOP;
    assign alusel_o=(rst==`RST_ENABLE)?`ALUSEL_NOP:
                    (opcode==`OPCODE_ORI)?`ALUSEL_LOGIC:`ALUSEL_NOP;
    assign rdata1_o=(rst==`RST_ENABLE)?`ZERO_WORD:
                    (re1_o==`RD_ENABLE)?rdata1_i:`ZERO_WORD;
    assign rdata2_o=(rst==`RST_ENABLE)?`ZERO_WORD:
                    (re2_o==`RD_ENABLE)?rdata2_i:immext;
    assign waddr_o= (rst==`RST_ENABLE)?`NOP_REG_ADDR:
                    (opcode==`OPCODE_NOP)?rd:rt;
    assign we_o=(rst==`RST_ENABLE)?`WR_DISABLE:
                (opcode==`OPCODE_ORI)?`WR_ENABLE:`WR_DISABLE;             
/*
	assign PCSrc = (opcode == 6'h03 || opcode == 6'h02)?2'b01:(opcode==6'h00&&(funct==6'h08||funct==6'h09))?2'b10:2'b00;
	assign Branch = (opcode==6'h04)?1'b1:1'b0;
	assign RegWrite = (opcode==6'h2b||opcode==6'h04||opcode==6'h02||opcode==6'h00&&funct==6'h08)?1'b0:1'b1;
	assign RegDst = (opcode==6'h00)?2'b01:(opcode==6'h03)?2'b10:2'b00;
	assign MemRead = (opcode==6'h23)?1'b1:1'b0;
	assign MemWrite = (opcode==6'h2b)?1'b1:1'b0;
	assign MemtoReg = (opcode==6'h23)?2'b01:(opcode==6'h03||opcode==6'h00&&funct==6'h09)?2'b10:2'b00;
	assign ALUSrc1 = (opcode==6'h00&&(funct==6'h00||funct==6'h02||funct==6'h03))?1'b1:1'b0;
	assign ALUSrc2 = (opcode==6'h00||opcode==6'h04)?1'b0:1'b1;
	assign LuOp = (opcode == 6'h0f)?1'b1:1'b0;
*/  
endmodule