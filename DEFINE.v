
/**全局宏定义**/
`define RST_ENABLE 1'b1
`define RST_DISABLE 1'b0
`define ZERO_WORD 32'h0000_0000
`define WR_ENABLE 1'b1
`define WR_DISABLE 1'b0
`define RD_ENABLE 1'b1
`define RD_DISABLE 1'b0
`define ALUOP_BUS 7:0
`define ALUSEL_BUS 2:0
`define INST_VALID 1'b0
`define INST_INVALID 1'b1
`define TRUE 1'b1
`define FALSE 1'b0
`define CHIP_ENABLE 1'b1
`define CHIP_DISABLE 1'b0

/**具体指令宏定义**/
//Opcode
`define OPCODE_NOP 6'h00
`define OPCODE_J 6'h02
`define OPCODE_JAL 6'h03
`define OPCODE_BEQ 6'h04

`define OPCODE_ANDI 6'h0C
`define OPCODE_ORI 6'h0D
`define OPCODE_XORI 6'h0E
`define OPCODE_LUI 6'h0F
`define OPCODE_SW 6'h2B
//Funct
`define FUNCT_SLL 6'h00
`define FUNCT_SRL 6'h02
`define FUNCT_SRA 6'h03
`define FUNCT_SLLV 6'h04
`define FUNCT_SRLV 6'h06
`define FUNCT_SRAV 6'h07
`define FUNCT_JR 6'h08

`define FUNCT_AND 6'h24
`define FUNCT_OR 6'h25
`define FUNCT_XOR 6'h26
`define FUNCT_NOR 6'h27
//ALUOp
`define ALUOP_NOP 8'b0000_0000
`define ALUOP_AND 8'b0010_0100
`define ALUOP_OR 8'b0010_0101
`define ALUOP_XOR 8'b0010_0110
`define ALUOP_NOR 8'b0010_0111
`define ALUOP_LUI 8'b0101_1100
`define ALUOP_SLL 8'b0111_1100
`define ALUOP_SRL 8'b0000_0010
`define ALUOP_SRA 8'b0000_0011
//ALUSel
`define ALUSEL_NOP 3'b000
`define ALUSEL_LOGIC 3'b001
`define ALUSEL_SHIFT 3'b010

/**指令存储器ROM宏定义**/
`define INST_ADDR_BUS 31:0
`define INST_BUS 31:0



/**通用寄存器RF宏定义**/
`define REG_ADDR_BUS 4:0
`define REG_BUS 31:0
`define REG_WIDTH 32
`define DOUBLE_REG_BUS 63:0
`define DOUBLE_REG_WIDTH 64
`define REG_NUM 32
`define REG_NUM_LOG2 5
`define NOP_REG_ADDR 5'b00000

/****/
/****/
/****/
/****/
/****/
/****/
/****/