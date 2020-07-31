
`include "DEFINE.v"
module ID(
    input wire rst,
    input wire [`INST_ADDR_BUS] pc_i,
    input wire [`INST_BUS] inst_i,
    //from regfile
    input wire [`REG_BUS] rdata1_i,
    input wire [`REG_BUS] rdata2_i,
    //from ex
    input wire [`REG_ADDR_BUS] ex_waddr_i,
    input wire ex_we_i,
    input wire [`REG_BUS] ex_wdata_i,
    input wire ex_mre_i,
    //from mem
    input wire [`REG_ADDR_BUS] mem_waddr_i,
    input wire mem_we_i,
    input wire [`REG_BUS] mem_wdata_i,
    //to regfile
    output wire re1_o,
    output wire re2_o,
    output wire [`REG_ADDR_BUS] raddr1_o,
    output wire [`REG_ADDR_BUS] raddr2_o,
    //to id_ex
    output reg [`ALUOP_BUS] aluop_o,
    output reg [`ALUSEL_BUS] alusel_o,
    output wire [`REG_BUS] rdata1_o,
    output wire [`REG_BUS] rdata2_o,
    output wire [`REG_ADDR_BUS] waddr_o,
    output wire we_o,
    output wire [`INST_ADDR_BUS] laddr_o,
    output wire mre_o,
    output wire mwe_o,
    output wire [`MEM_BUS] mwdata_o,
    //to ctrl
    output wire jbstallreq_o,
    output wire lwstallreq_o,
    //to pc
    output wire be_o,
    output wire [`INST_ADDR_BUS] baddr_o
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
    wire [`INST_ADDR_BUS] pc_plus_4;

    assign opcode=inst_i[31:26];
    assign rs=inst_i[25:21];
    assign rt=inst_i[20:16];
    assign rd=inst_i[15:11];
    assign shamt=inst_i[10:6];
    assign funct=inst_i[5:0];
    assign imm=inst_i[15:0];
	assign immext = ((opcode==`OPCODE_ANDI)||(opcode==`OPCODE_ORI)||(opcode==`OPCODE_XORI))?{16'h0000,imm}:
                    (opcode==`OPCODE_LUI)?{imm,16'h0000}:{{16{imm[15]}},imm};

    assign target=inst_i[25:0];
    assign pc_plus_4=pc_i+32'h0000_0004;
    //to regfile
    assign re1_o=   (rst==`RST_ENABLE)?`RD_DISABLE:
                    ((opcode==`OPCODE_J)||(opcode==`OPCODE_JAL)||
                    ((opcode==`OPCODE_NOP)&&((funct==`FUNCT_SLL)||(funct==`FUNCT_SRL)||(funct==`FUNCT_SRA))))?`RD_DISABLE:`RD_ENABLE;
    assign re2_o=   (rst==`RST_ENABLE)?`RD_DISABLE:
                    (opcode==`OPCODE_NOP)||(opcode==`OPCODE_BEQ)||(opcode==`OPCODE_BNE)||(opcode==`OPCODE_SW)?`RD_ENABLE:`RD_DISABLE;
    assign raddr1_o=(rst==`RST_ENABLE)?`NOP_REG_ADDR:rs;
    assign raddr2_o=(rst==`RST_ENABLE)?`NOP_REG_ADDR:rt;
    //to id_ex
    always @(*) begin
        if(rst==`RST_ENABLE) begin
            aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_NOP;
        end else begin
            case(opcode)
                `OPCODE_NOP:begin
                    if(rs==5'b00000||shamt==5'b00000) begin
                        case(funct)
                            `FUNCT_SLL:begin
                                aluop_o<=`ALUOP_SLL;alusel_o<=`ALUSEL_SHIFT;
                            end
                            `FUNCT_SRL:begin
                                aluop_o<=`ALUOP_SRL;alusel_o<=`ALUSEL_SHIFT;
                            end
                            `FUNCT_SRA:begin
                                aluop_o<=`ALUOP_SRA;alusel_o<=`ALUSEL_SHIFT;
                            end
                            `FUNCT_SLLV:begin
                                aluop_o<=`ALUOP_SLL;alusel_o<=`ALUSEL_SHIFT;
                            end
                            `FUNCT_SRLV:begin
                                aluop_o<=`ALUOP_SRL;alusel_o<=`ALUSEL_SHIFT;
                            end
                            `FUNCT_SRAV:begin
                                aluop_o<=`ALUOP_SRA;alusel_o<=`ALUSEL_SHIFT;
                            end
                            `FUNCT_JR:begin
                                aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_NOP;
                            end
                            `FUNCT_JALR:begin
                                aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_LINK;
                            end
                            `FUNCT_ADD:begin
                                aluop_o<=`ALUOP_ADD;alusel_o<=`ALUSEL_ARITHMETIC;
                            end
                            `FUNCT_ADDU:begin
                                aluop_o<=`ALUOP_ADDU;alusel_o<=`ALUSEL_ARITHMETIC;
                            end
                            `FUNCT_SUB:begin
                                aluop_o<=`ALUOP_SUB;alusel_o<=`ALUSEL_ARITHMETIC;
                            end
                            `FUNCT_SUBU:begin
                                aluop_o<=`ALUOP_SUBU;alusel_o<=`ALUSEL_ARITHMETIC;
                            end                            
                            `FUNCT_AND:begin
                                aluop_o<=`ALUOP_AND;alusel_o<=`ALUSEL_LOGIC;
                            end
                            `FUNCT_OR:begin
                                aluop_o<=`ALUOP_OR;alusel_o<=`ALUSEL_LOGIC;
                            end
                            `FUNCT_XOR:begin
                                aluop_o<=`ALUOP_XOR;alusel_o<=`ALUSEL_LOGIC;
                            end
                            `FUNCT_NOR:begin
                                aluop_o<=`ALUOP_NOR;alusel_o<=`ALUSEL_LOGIC;
                            end
                            `FUNCT_SLT:begin
                                aluop_o<=`ALUOP_SLT;alusel_o<=`ALUSEL_ARITHMETIC;
                            end
                            `FUNCT_SLTU:begin
                                aluop_o<=`ALUOP_SLTU;alusel_o<=`ALUSEL_ARITHMETIC;
                            end

                        endcase
                    end else begin
                        aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_NOP;                       
                    end
                end
                `OPCODE_J:begin
                    aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_NOP;
                end
                `OPCODE_JAL:begin
                    aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_LINK;
                end
                `OPCODE_BEQ:begin
                    aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_NOP;
                end
                `OPCODE_BNE:begin
                    aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_NOP;
                end
                `OPCODE_BLEZ:begin
                    aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_NOP;
                end
                `OPCODE_BGTZ:begin
                    aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_NOP;
                end        
                `OPCODE_ADDI:begin
                    aluop_o<=`ALUOP_ADD;alusel_o<=`ALUSEL_ARITHMETIC;
                end
                `OPCODE_ADDIU:begin
                    aluop_o<=`ALUOP_ADDU;alusel_o<=`ALUSEL_ARITHMETIC;
                end
                `OPCODE_SLTI:begin
                    aluop_o<=`ALUOP_SLT;alusel_o<=`ALUSEL_ARITHMETIC;
                end
                `OPCODE_SLTIU:begin
                    aluop_o<=`ALUOP_SLTU;alusel_o<=`ALUSEL_ARITHMETIC;
                end                                             
                `OPCODE_ANDI:begin
                    aluop_o<=`ALUOP_AND;alusel_o<=`ALUSEL_LOGIC;
                end
                `OPCODE_ORI:begin
                    aluop_o<=`ALUOP_OR;alusel_o<=`ALUSEL_LOGIC;
                end
                `OPCODE_XORI:begin
                    aluop_o<=`ALUOP_XOR;alusel_o<=`ALUSEL_LOGIC;
                end
                `OPCODE_LUI:begin
                    aluop_o<=`ALUOP_OR;alusel_o<=`ALUSEL_LOGIC;
                end
                `OPCODE_LW:begin
                    aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_NOP;
                end
                `OPCODE_SW:begin
                    aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_NOP;
                end              
                default:begin
                    aluop_o<=`ALUOP_NOP;alusel_o<=`ALUSEL_NOP;
                end
            endcase
        end
    end

    assign rdata1_o=(rst==`RST_ENABLE)?`ZERO_WORD:
                    ((re1_o==`RD_ENABLE)&&(ex_we_i==`WR_ENABLE)&&(ex_waddr_i==raddr1_o)&&(ex_mre_i==`RD_DISABLE))?ex_wdata_i:
                    ((re1_o==`RD_ENABLE)&&(mem_we_i==`WR_ENABLE)&&(mem_waddr_i==raddr1_o))?mem_wdata_i:
                    (re1_o==`RD_ENABLE)?rdata1_i:{27'b0,shamt};//for shamt in shift-type
    assign rdata2_o=(rst==`RST_ENABLE)?`ZERO_WORD:
                    (opcode==`OPCODE_SW)?immext:
                    ((re2_o==`RD_ENABLE)&&(ex_we_i==`WR_ENABLE)&&(ex_waddr_i==raddr2_o)&&(ex_mre_i==`RD_DISABLE))?ex_wdata_i:
                    ((re2_o==`RD_ENABLE)&&(mem_we_i==`WR_ENABLE)&&(mem_waddr_i==raddr2_o))?mem_wdata_i:
                    (re2_o==`RD_ENABLE)?rdata2_i:immext;//for immext in I-type
    assign waddr_o= (rst==`RST_ENABLE)?`NOP_REG_ADDR:
                    (opcode==`OPCODE_JAL)?`RA_REG_ADDR:
                    (opcode==`OPCODE_SW)?`NOP_REG_ADDR:
                    (opcode==`OPCODE_NOP)?rd:rt;//include the situation of jalr and lw
    assign we_o=(rst==`RST_ENABLE)?`WR_DISABLE:
                ((opcode==`OPCODE_J)||(opcode==`OPCODE_BEQ)||
                (opcode==`OPCODE_BNE)||(opcode==`OPCODE_BLEZ)||
                (opcode==`OPCODE_BGTZ)||(opcode==`OPCODE_SW)||
                ((opcode==`OPCODE_NOP)&&(funct==`FUNCT_JR)))?`WR_DISABLE:`WR_ENABLE;
    assign laddr_o= (rst==`RST_ENABLE)?`ZERO_WORD:
                    (opcode==`OPCODE_JAL)||((opcode==`OPCODE_NOP)&&(funct==`FUNCT_JALR))?pc_plus_4:`ZERO_WORD;
    assign mre_o=   (rst==`RST_ENABLE)?`RD_DISABLE:
                    (opcode==`OPCODE_LW)?`RD_ENABLE:`RD_DISABLE;
    assign mwe_o=   (rst==`RST_ENABLE)?`WR_DISABLE:
                    (opcode==`OPCODE_SW)?`WR_ENABLE:`WR_DISABLE;
    assign mwdata_o=(rst==`RST_ENABLE)?`ZERO_WORD:
                    (opcode!=`OPCODE_SW)?`ZERO_WORD:
                    ((ex_we_i==`WR_ENABLE)&&(ex_waddr_i==raddr2_o)&&(ex_mre_i==`RD_DISABLE))?ex_wdata_i:
                    ((mem_we_i==`WR_ENABLE)&&(mem_waddr_i==raddr2_o))?mem_wdata_i:rdata2_i;
    assign jbstallreq_o=(rst==`RST_ENABLE)?`STALLREQ_DISABLE:
                        (opcode==`OPCODE_J)||(opcode==`OPCODE_JAL)||
                        (opcode==`OPCODE_BEQ)||(opcode==`OPCODE_BNE)||
                        (opcode==`OPCODE_BLEZ)||(opcode==`OPCODE_BGTZ)||
                        (opcode==`OPCODE_NOP)&&((funct==`FUNCT_JR)||(funct==`FUNCT_JALR))?`STALLREQ_ENABLE:`STALLREQ_DISABLE;
    assign lwstallreq_o=(ex_we_i==`WR_ENABLE)&&(ex_mre_i==`RD_ENABLE)&&
                        (((re1_o==`RD_ENABLE)&&(ex_waddr_i==raddr1_o))||((re2_o==`RD_ENABLE)&&(ex_waddr_i==raddr2_o)))?`STALLREQ_ENABLE:`STALLREQ_DISABLE;

    assign be_o=(rst==`RST_ENABLE)?`BRANCH_DISABLE:
                (opcode==`OPCODE_J)||(opcode==`OPCODE_JAL)||((opcode==`OPCODE_NOP)&&((funct==`FUNCT_JR)||(funct==`FUNCT_JALR)))?`BRANCH_ENABLE:
                (opcode==`OPCODE_BEQ)&&(rdata1_o==rdata2_o)?`BRANCH_ENABLE:
                (opcode==`OPCODE_BNE)&&(rdata1_o!=rdata2_o)?`BRANCH_ENABLE:
                (opcode==`OPCODE_BLEZ)&&(rdata1_o[31]==1'b1||rdata1_o==`ZERO_WORD)?`BRANCH_ENABLE:
                (opcode==`OPCODE_BGTZ)&&(rdata1_o[31]==1'b0&&rdata1_o!=`ZERO_WORD)?`BRANCH_ENABLE:`BRANCH_DISABLE;
    assign baddr_o= (rst==`RST_ENABLE)?`ZERO_WORD:
                    (opcode==`OPCODE_J)||(opcode==`OPCODE_JAL)?{pc_plus_4[31:28],target,2'b00}:
                    (opcode==`OPCODE_NOP)&&((funct==`FUNCT_JR)||(funct==`FUNCT_JALR))?rdata1_o:
                    (opcode==`OPCODE_BEQ)||(opcode==`OPCODE_BNE)||(opcode==`OPCODE_BLEZ)||(opcode==`OPCODE_BGTZ)?pc_plus_4+(immext<<2'd2):`ZERO_WORD;

endmodule