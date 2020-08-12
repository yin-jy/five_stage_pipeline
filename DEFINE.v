
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
`define OPCODE_BNE 6'h05
`define OPCODE_BLEZ 6'h06
`define OPCODE_BGTZ 6'h07
`define OPCODE_ADDI 6'h08
`define OPCODE_ADDIU 6'h09
`define OPCODE_SLTI 6'h0A
`define OPCODE_SLTIU 6'h0B
`define OPCODE_ANDI 6'h0C
`define OPCODE_ORI 6'h0D
`define OPCODE_XORI 6'h0E
`define OPCODE_LUI 6'h0F
`define OPCODE_LW 6'h23
`define OPCODE_SW 6'h2B
//Funct
`define FUNCT_SLL 6'h00
`define FUNCT_SRL 6'h02
`define FUNCT_SRA 6'h03
`define FUNCT_SLLV 6'h04
`define FUNCT_SRLV 6'h06
`define FUNCT_SRAV 6'h07
`define FUNCT_JR 6'h08
`define FUNCT_JALR 6'h09
`define FUNCT_ADD 6'h20
`define FUNCT_ADDU 6'h21
`define FUNCT_SUB 6'h22
`define FUNCT_SUBU 6'h23
`define FUNCT_AND 6'h24
`define FUNCT_OR 6'h25
`define FUNCT_XOR 6'h26
`define FUNCT_NOR 6'h27
`define FUNCT_SLT 6'h2A
`define FUNCT_SLTU 6'h2B
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

`define ALUOP_SLT 8'b0010_1010
`define ALUOP_SLTU 8'b0010_1011
`define ALUOP_ADD 8'b0010_0000
`define ALUOP_ADDU 8'b0010_0001
`define ALUOP_SUB 8'b0010_0010
`define ALUOP_SUBU 8'b0010_0011
//ALUSel
`define ALUSEL_NOP 3'b000
`define ALUSEL_LOGIC 3'b001
`define ALUSEL_SHIFT 3'b010
`define ALUSEL_ARITHMETIC 3'b100
`define ALUSEL_LINK 3'b110

/**指令存储器ROM宏定义**/
`define INST_ADDR_BUS 31:0
`define INST_BUS 31:0

/**通用寄存器RegisterFile宏定义**/
`define REG_ADDR_BUS 4:0
`define REG_BUS 31:0
`define REG_WIDTH 32
`define DOUBLE_REG_BUS 63:0
`define DOUBLE_REG_WIDTH 64
`define REG_NUM 32
`define REG_NUM_LOG2 5
`define NOP_REG_ADDR 5'b00000
`define RA_REG_ADDR 5'b11111

/**执行模块EX宏定义**/
`define OVERFLOW_ENABLE 1'b1
`define OVERFLOW_DISABLE 1'b0

/**控制模块CTRL宏定义**/
`define STALL_BUS 5:0
`define STALLREQ_ENABLE 1'b1
`define STALLREQ_DISABLE 1'b0
`define NO_STALL 6'b000000
`define JB_STALL 6'b000010
`define LW_STALL 6'b000111
`define EX_STALL 6'b001111
`define STALL_ENABLE 1'b1
`define STALL_DISABLE 1'b0

/**译码模块ID宏定义**/
`define BRANCH_ENABLE 1'b1
`define BRANCH_DISABLE 1'b0

/**访存模块MEM宏定义**/
`define MEM_ADDR_BUS 31:0
`define MEM_BUS 31:0

/**随机存储器RAM宏定义**/
`define RAM_WORDS 512

/**程序计数器PC宏定义**/
`define PC_RST_WORD 32'h8000_0000
`define PC_INT_WORD 32'h8000_0004
`define PC_EXC_WORD 32'h8000_0008

/**外设控制器PeripheralControl宏定义**/
`define TL_FULL_WORD 32'hffff_ffff
`define TIMER_ENABLE 1'b1
`define TIMER_DISABLE 1'b0
`define INT_ENABLE 1'b1
`define INT_DISABLE 1'b0
`define TIMER_INT_STATUS 1'b1
`define TIMER_CNT_STATUS 1'b0