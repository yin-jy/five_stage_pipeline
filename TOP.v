
`include "DEFINE.v"
module TOP(
    input wire rst,
    input wire clk,
    output wire [`INST_BUS] temp
);

	//connect cpu and instructionmemory
	wire [`INST_BUS] rom_data;
	wire rom_ce;
	wire [`INST_ADDR_BUS] rom_addr;
	//connect cpu and datamemory
	wire [`MEM_BUS] ram_rdata;
	wire ram_cre;
	wire ram_cwe;
	//connect cpu and peripheralcontrol
	wire [`MEM_BUS] peri_rdata;
	wire peri_cre;
	wire peri_cwe;
	//connect cpu and datamemory/peripheralcontrol
	wire [`MEM_ADDR_BUS] ram_peri_addr;
	wire [`MEM_BUS] ram_peri_wdata;

	CPU CPU0(
		.rst(rst),
		.clk(clk),
		//with instructionmemory
		.rom_data_i(rom_data),
		.rom_addr_o(rom_addr),
		.rom_ce_o(rom_ce),
		//with datamemory
		.ram_rdata_i(ram_rdata),
		.ram_cre_o(ram_cre),
		.ram_cwe_o(ram_cwe),
		//with peripheralcontrol
		.peri_rdata_i(peri_rdata),
		.peri_cre_o(peri_cre),
		.peri_cwe_o(peri_cwe),
		//with datamemory and peripheralcontrol
		.ram_peri_addr_o(ram_peri_addr),
		.ram_peri_wdata_o(ram_peri_wdata)
	);

	InstructionMemory InstructionMemory0(
		.rom_addr_i(rom_addr),
		.rom_ce_i(rom_ce),
		.rom_data_o(rom_data)
	);

	DataMemory DataMemory0(
		.rst(rst),
		.clk(clk),
		.ram_cre_i(ram_cre),
		.ram_cwe_i(ram_cwe),
		.ram_addr_i(ram_peri_addr),
		.ram_wdata_i(ram_peri_wdata),
		.ram_rdata_o(ram_rdata)
	);

	PeripheralControl PeripheralControl0(
		.rst(rst),
		.clk(clk),
		.peri_cre_i(peri_cre),
		.peri_cwe_i(peri_cwe),
		.peri_addr_i(ram_peri_addr),
		.peri_wdata_i(ram_peri_wdata),
		.peri_rdata_o(peri_rdata)
	);

    assign temp=rom_data;

endmodule