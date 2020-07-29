
`include "DEFINE.v"
module InstructionMemory(
	input wire [`INST_ADDR_BUS] rom_addr_i,
	input wire rom_ce_i,
	output wire [`INST_BUS] rom_data_o
);
	
	assign rom_data_o=	(rom_ce_i==`CHIP_DISABLE)?`ZERO_WORD:
						(rom_addr_i==32'h0000_0000)?32'h3c020404:
						(rom_addr_i==32'h0000_0004)?32'h34420404:
						(rom_addr_i==32'h0000_0008)?32'h34070007:
						(rom_addr_i==32'h0000_000C)?32'h34050005:
						(rom_addr_i==32'h0000_0010)?32'h34080008:
						(rom_addr_i==32'h0000_0014)?32'h00000000:
						(rom_addr_i==32'h0000_0018)?32'h00021200:
						(rom_addr_i==32'h0000_001C)?32'h00e21004:
						(rom_addr_i==32'h0000_0020)?32'h00021202:
						(rom_addr_i==32'h0000_0024)?32'h00a21006:
						(rom_addr_i==32'h0000_0028)?32'h00000000:
						(rom_addr_i==32'h0000_002C)?32'h00000000:
						(rom_addr_i==32'h0000_0030)?32'h000214c0:
						(rom_addr_i==32'h0000_0034)?32'h00000000:
						(rom_addr_i==32'h0000_0038)?32'h00021403:
						(rom_addr_i==32'h0000_003C)?32'h01021007:
						`ZERO_WORD;

endmodule
