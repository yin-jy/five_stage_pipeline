
`include "DEFINE.v"
module TOP(
    input wire rst,
    input wire clk,
    output wire [`INST_BUS] temp
);

	wire [`INST_BUS] rom_data;
	wire rom_ce;
	wire [`INST_ADDR_BUS] rom_addr;

	CPU CPU0(
		.rst(rst),
		.clk(clk),
		.rom_data_i(rom_data),
		.rom_addr_o(rom_addr),
		.rom_ce_o(rom_ce)
	);

	InstructionMemory InstructionMemory0(
		.rom_addr_i(rom_addr),
		.rom_ce_i(rom_ce),
		.rom_data_o(rom_data)
	);

    assign temp=rom_data;

endmodule