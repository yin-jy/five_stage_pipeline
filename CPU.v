
`include "DEFINE.v"
module CPU(
	input wire rst,
	input wire clk,

	input wire [`INST_BUS] rom_data_i,
	output wire [`INST_ADDR_BUS] rom_addr_o,
	output wire rom_ce_o
);

	//connect if_id and id
	wire [`INST_ADDR_BUS] pc;
	wire [`INST_ADDR_BUS] id_pc_i;
	wire [`INST_BUS] id_inst_i;
    //connect id and id_ex
    wire [`ALUOP_BUS] id_aluop_o;
    wire [`ALUSEL_BUS] id_alusel_o;
    wire [`REG_BUS] id_rdata1_o;
    wire [`REG_BUS] id_rdata2_o;
    wire [`REG_ADDR_BUS] id_waddr_o;
	wire id_we_o;
	//connect id_ex and ex
    wire [`ALUOP_BUS] ex_aluop_i;
    wire [`ALUSEL_BUS] ex_alusel_i;
    wire [`REG_BUS] ex_rdata1_i;
    wire [`REG_BUS] ex_rdata2_i;
    wire [`REG_ADDR_BUS] ex_waddr_i;
    wire ex_we_i;
	//connect ex and ex_mem
    wire [`REG_ADDR_BUS] ex_waddr_o;
    wire ex_we_o;
    wire [`REG_BUS] ex_wdata_o;
	//connect ex_mem and mem
    wire [`REG_ADDR_BUS] mem_waddr_i;
    wire mem_we_i;
    wire [`REG_BUS] mem_wdata_i;	
	//connect mem and mem_wb
    wire [`REG_ADDR_BUS] mem_waddr_o;
    wire mem_we_o;
    wire [`REG_BUS] mem_wdata_o;
	//connect mem_wb and wb
    wire [`REG_ADDR_BUS] wb_waddr_i;
    wire wb_we_i;
    wire [`REG_BUS] wb_wdata_i;
	//connect id and regfile
    wire [`REG_BUS] id_rdata1_i;
    wire [`REG_BUS] id_rdata2_i;
	wire id_re1_o;
	wire id_re2_o;
	wire [`REG_ADDR_BUS] id_raddr1_o;
	wire [`REG_ADDR_BUS] id_raddr2_o;

	//pc instantiation
	PC PC0(
		.clk(clk),
		.rst(rst),
		.pc(pc),
		.ce(rom_ce_o)
	);
	assign rom_addr_o=pc;
	//if_id instantiation
	IF_ID IF_ID0(
		.clk(clk),
		.rst(rst),
		.if_pc(pc),
		.if_inst(rom_data_i),
		.id_pc(id_pc_i),
		.id_inst(id_inst_i)
	);
	//id instantiation
	ID ID0(
		.rst(rst),
		.pc_i(id_pc_i),
		.inst_i(id_inst_i),
		//from regfile
		.rdata1_i(id_rdata1_i),
		.rdata2_i(id_rdata2_i),
		//to regfile
		.re1_o(id_re1_o),
		.re2_o(id_re2_o),
		.raddr1_o(id_raddr1_o),
		.raddr2_o(id_raddr2_o),
		//to id_ex
		.aluop_o(id_aluop_o),
		.alusel_o(id_alusel_o),
		.rdata1_o(id_rdata1_o),
		.rdata2_o(id_rdata2_o),
		.waddr_o(id_waddr_o),
		.we_o(id_we_o)
	);
	//registerfile instantiation
	RegisterFile RegisterFile0(
		.rst(rst),
		.clk(clk),
		//from wb
		.we(wb_we_i),
		.waddr(wb_waddr_i),
		.wdata(wb_wdata_i),
		//from and to id
		.re1(id_re1_o),
		.raddr1(id_raddr1_o),
		.rdata1(id_rdata1_i),
		//from and to id
		.re2(id_re2_o),
		.raddr2(id_raddr2_o),
		.rdata2(id_rdata2_i)
	);
	//id_ex instantiation
	ID_EX ID_EX0(
		.rst(rst),
		.clk(clk),
		//from id
		.id_aluop(id_aluop_o),
		.id_alusel(id_alusel_o),
		.id_rdata1(id_rdata1_o),
		.id_rdata2(id_rdata2_o),
		.id_waddr(id_waddr_o),
		.id_we(id_we_o),
		//to ex
		.ex_aluop(ex_aluop_i),
		.ex_alusel(ex_alusel_i),
		.ex_rdata1(ex_rdata1_i),
		.ex_rdata2(ex_rdata2_i),
		.ex_waddr(ex_waddr_i),
		.ex_we(ex_we_i)		
	);
	//ex instantiation
	EX EX0(
		.rst(rst),
		//from id_ex
		.aluop_i(ex_aluop_i),
		.alusel_i(ex_alusel_i),
		.rdata1_i(ex_rdata1_i),
		.rdata2_i(ex_rdata2_i),
		.waddr_i(ex_waddr_i),
		.we_i(ex_we_i),
		//to ex_mem
		.waddr_o(ex_waddr_o),
		.we_o(ex_we_o),
		.wdata_o(ex_wdata_o)
	);	
	//ex_mem instantiation
	EX_MEM EX_MEM0(
		.clk(clk),
		.rst(rst),
		//from ex
		.ex_waddr(ex_waddr_o),
		.ex_we(ex_we_o),
		.ex_wdata(ex_wdata_o),
		//to mem
		.mem_waddr(mem_waddr_i),
		.mem_we(mem_we_i),
		.mem_wdata(mem_wdata_i)
	);
	//mem instantiation
	MEM MEM0(
		.rst(rst),
		.clk(clk),
		//from ex
		.waddr_i(mem_waddr_i),
		.we_i(mem_we_i),
		.wdata_i(mem_wdata_i),
		//to wb
		.waddr_o(mem_waddr_o),
		.we_o(mem_we_o),
		.wdata_o(mem_wdata_o)
	);
	//mem_wb instantiation
	MEM_WB MEM_WB0(
		.rst(rst),
		.clk(clk),
		//from mem
		.mem_waddr(mem_waddr_o),
		.mem_we(mem_we_o),
		.mem_wdata(mem_wdata_o),
		//to wb
		.wb_waddr(wb_waddr_i),
		.wb_we(wb_we_i),
		.wb_wdata(wb_wdata_i)
	);

endmodule