
`include "DEFINE.v"
module InstructionMemory(
	input wire [`INST_ADDR_BUS] rom_addr_i,
	input wire rom_ce_i,
	output wire [`INST_BUS] rom_data_o
);
	
	assign rom_data_o=	(rom_ce_i==`CHIP_DISABLE)?`ZERO_WORD:
						(rom_addr_i==32'h0000_0000)?32'h3401_1100:
						(rom_addr_i==32'h0000_0004)?32'h3402_0020:
						(rom_addr_i==32'h0000_0008)?32'h3403_FF00:
						(rom_addr_i==32'h0000_000C)?32'h3404_FFFF:`ZERO_WORD;

endmodule
