
`include "DEFINE.v"
module CPU(
	input wire rst,
	input wire clk,
	//with instructionmemory
	input wire [`INST_BUS] rom_data_i,
	output wire [`INST_ADDR_BUS] rom_addr_o,
	output wire rom_ce_o,
	//with datamemory
	input wire [`MEM_BUS] ram_rdata_i,
	output wire ram_cre_o,
	output wire ram_cwe_o,
	//with peripheralcontrol
	input wire [`MEM_BUS] peri_rdata_i,
	input wire peri_intreq_i,
	output wire peri_cre_o,
	output wire peri_cwe_o,
	output wire peri_pc31_o,
	//with datamemory and peripheralcontrol
	output wire [`MEM_ADDR_BUS] ram_peri_addr_o,
	output wire [`MEM_BUS] ram_peri_wdata_o
);

	wire [`INST_ADDR_BUS] pc;
	//connect if_id and id
	wire [`INST_ADDR_BUS] id_pc_i;
	wire [`INST_BUS] id_inst_i;
    //connect id and id_ex
    wire [`ALUOP_BUS] id_aluop_o;
    wire [`ALUSEL_BUS] id_alusel_o;
    wire [`REG_BUS] id_rdata1_o;
    wire [`REG_BUS] id_rdata2_o;
    wire [`REG_ADDR_BUS] id_waddr_o;
	wire id_we_o;
	wire [`INST_ADDR_BUS] id_laddr_o;
	wire id_mre_o;
	wire id_mwe_o;
	wire [`MEM_BUS] id_mwdata_o;
	//connect id_ex and ex
    wire [`ALUOP_BUS] ex_aluop_i;
    wire [`ALUSEL_BUS] ex_alusel_i;
    wire [`REG_BUS] ex_rdata1_i;
    wire [`REG_BUS] ex_rdata2_i;
    wire [`REG_ADDR_BUS] ex_waddr_i;
    wire ex_we_i;
	wire [`INST_ADDR_BUS] ex_laddr_i;
	wire ex_mre_i;
	wire ex_mwe_i;
	wire [`MEM_BUS] ex_mwdata_i;
	//connect ex and ex_mem
    wire [`REG_ADDR_BUS] ex_waddr_o;
    wire ex_we_o;
    wire [`REG_BUS] ex_wdata_o;
	wire ex_mre_o;
	wire ex_mwe_o;
	wire [`MEM_BUS] ex_mwdata_o;
	wire [`MEM_ADDR_BUS] ex_maddr_o;
	//connect ex_mem and mem
    wire [`REG_ADDR_BUS] mem_waddr_i;
    wire mem_we_i;
    wire [`REG_BUS] mem_wdata_i;
	wire mem_mre_i;
	wire mem_mwe_i;
	wire [`MEM_BUS] mem_mwdata_i;
	wire [`MEM_ADDR_BUS] mem_maddr_i;
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
	//connect pc/if_id/id_ex/ex_mem/mem_wb and ctrl
	wire [`STALL_BUS] ctrl_stall_o;
	//connect id and ctrl
	wire id_jbstallreq_o;
	wire id_lwstallreq_o;
	//connect ex and ctrl
	wire ex_stallreq_o;
	//connect id and pc
	wire id_be_o;
	wire [`INST_ADDR_BUS] id_baddr_o;

	//pc instantiation
	PC PC0(
		.clk(clk),
		.rst(rst),
		.ctrl_stall(ctrl_stall_o),
		.be(id_be_o),
		.baddr(id_baddr_o),
		.ie(peri_intreq_i),
		.pc(pc),
		.ce(rom_ce_o)
	);
	assign rom_addr_o={1'b0,pc[30:0]};
	assign peri_pc31_o=pc[31];
	//if_id instantiation
	IF_ID IF_ID0(
		.clk(clk),
		.rst(rst),
		.if_pc(pc),
		.if_inst(rom_data_i),
		.ctrl_stall(ctrl_stall_o),
		.id_pc(id_pc_i),
		.id_inst(id_inst_i)
	);
	//id instantiation
	ID ID0(
		.rst(rst),
		//from if
		.pc_i(id_pc_i),
		.inst_i(id_inst_i),
		//from regfile
		.rdata1_i(id_rdata1_i),
		.rdata2_i(id_rdata2_i),
		//from ex
		.ex_waddr_i(ex_waddr_o),
		.ex_we_i(ex_we_o),
		.ex_wdata_i(ex_wdata_o),
		.ex_mre_i(ex_mre_o),
		//from mem
		.mem_waddr_i(mem_waddr_o),
		.mem_we_i(mem_we_o),
		.mem_wdata_i(mem_wdata_o),
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
		.we_o(id_we_o),
		.laddr_o(id_laddr_o),
		.mre_o(id_mre_o),
		.mwe_o(id_mwe_o),
		.mwdata_o(id_mwdata_o),
		//to ctrl
		.jbstallreq_o(id_jbstallreq_o),
		.lwstallreq_o(id_lwstallreq_o),
		//to pc
		.be_o(id_be_o),
		.baddr_o(id_baddr_o)
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
		.rdata2(id_rdata2_i),
		//from id
		.baddr(id_baddr_o),
		.be(id_be_o),
		//from pc and cpu
		.pc(pc),
		.epce(peri_intreq_i)
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
		.id_laddr(id_laddr_o),
		.id_mre(id_mre_o),
		.id_mwe(id_mwe_o),
		.id_mwdata(id_mwdata_o),
		//from ctrl
		.ctrl_stall(ctrl_stall_o),
		//to ex
		.ex_aluop(ex_aluop_i),
		.ex_alusel(ex_alusel_i),
		.ex_rdata1(ex_rdata1_i),
		.ex_rdata2(ex_rdata2_i),
		.ex_waddr(ex_waddr_i),
		.ex_we(ex_we_i),
		.ex_laddr(ex_laddr_i),
		.ex_mre(ex_mre_i),
		.ex_mwe(ex_mwe_i),
		.ex_mwdata(ex_mwdata_i)
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
		.laddr_i(ex_laddr_i),
		.mre_i(ex_mre_i),
		.mwe_i(ex_mwe_i),
		.mwdata_i(ex_mwdata_i),
		//to ex_mem
		.waddr_o(ex_waddr_o),
		.we_o(ex_we_o),
		.wdata_o(ex_wdata_o),
		.mre_o(ex_mre_o),
		.mwe_o(ex_mwe_o),
		.mwdata_o(ex_mwdata_o),
		.maddr_o(ex_maddr_o),
		//to ctrl
		.stallreq_o(ex_stallreq_o)
	);	
	//ex_mem instantiation
	EX_MEM EX_MEM0(
		.clk(clk),
		.rst(rst),
		//from ex
		.ex_waddr(ex_waddr_o),
		.ex_we(ex_we_o),
		.ex_wdata(ex_wdata_o),
		.ex_mre(ex_mre_o),
		.ex_mwe(ex_mwe_o),
		.ex_mwdata(ex_mwdata_o),
		.ex_maddr(ex_maddr_o),
		//from ctrl
		.ctrl_stall(ctrl_stall_o),
		//to mem
		.mem_waddr(mem_waddr_i),
		.mem_we(mem_we_i),
		.mem_wdata(mem_wdata_i),
		.mem_mre(mem_mre_i),
		.mem_mwe(mem_mwe_i),
		.mem_mwdata(mem_mwdata_i),
		.mem_maddr(mem_maddr_i)
	);
	//mem instantiation
	MEM MEM0(
		.rst(rst),
		.clk(clk),
		//from ex
		.waddr_i(mem_waddr_i),
		.we_i(mem_we_i),
		.wdata_i(mem_wdata_i),
		.mre_i(mem_mre_i),
		.mwe_i(mem_mwe_i),
		.mwdata_i(mem_mwdata_i),
		.maddr_i(mem_maddr_i),
		//from datamemory
		.mrdata_i(ram_rdata_i),
		//from peripheralcontrol
		.prdata_i(peri_rdata_i),
		//to wb
		.waddr_o(mem_waddr_o),
		.we_o(mem_we_o),
		.wdata_o(mem_wdata_o),
		//to datamemory
		.mre_o(ram_cre_o),
		.mwe_o(ram_cwe_o),
		//to peripheralcontrol
		.pre_o(peri_cre_o),
		.pwe_o(peri_cwe_o),
		//to datamemory and peripheralcontrol
		.mpaddr_o(ram_peri_addr_o),
		.mpwdata_o(ram_peri_wdata_o)
	);
	//mem_wb instantiation
	MEM_WB MEM_WB0(
		.rst(rst),
		.clk(clk),
		//from mem
		.mem_waddr(mem_waddr_o),
		.mem_we(mem_we_o),
		.mem_wdata(mem_wdata_o),
		//from ctrl
		.ctrl_stall(ctrl_stall_o),
		//to wb
		.wb_waddr(wb_waddr_i),
		.wb_we(wb_we_i),
		.wb_wdata(wb_wdata_i)
	);
	//ctrl instantiation
	CTRL CTRL0(
		.rst(rst),
		.id_jbstallreq_i(id_jbstallreq_o),
		.id_lwstallreq_i(id_lwstallreq_o),
		.ex_stallreq_i(ex_stallreq_o),
		.peri_intreq_i(peri_intreq_i),
		.stall_o(ctrl_stall_o)
	);

endmodule