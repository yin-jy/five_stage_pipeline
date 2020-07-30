
`include "DEFINE.v"
module InstructionMemory(
	input wire [`INST_ADDR_BUS] rom_addr_i,
	input wire rom_ce_i,
	output wire [`INST_BUS] rom_data_o
);
	
	assign rom_data_o=	(rom_ce_i==`CHIP_DISABLE)?`ZERO_WORD:
						(rom_addr_i==32'h0000_0000)?32'h34011234:
						(rom_addr_i==32'h0000_0004)?32'h00010c00:
						(rom_addr_i==32'h0000_0008)?32'h34215678:
						(rom_addr_i==32'h0000_000C)?32'hac010004:
						(rom_addr_i==32'h0000_0010)?32'h34028000:
						(rom_addr_i==32'h0000_0014)?32'h00021400:
						(rom_addr_i==32'h0000_0018)?32'h34420008:
						(rom_addr_i==32'h0000_001C)?32'h8c030004:
						(rom_addr_i==32'h0000_0020)?32'h24640001:
						(rom_addr_i==32'h0000_0024)?32'h34040008:
						(rom_addr_i==32'h0000_0028)?32'hac840000:
						(rom_addr_i==32'h0000_002C)?32'h8c050008:
						(rom_addr_i==32'h0000_0030)?32'h8ca60000:
						`ZERO_WORD;
endmodule
