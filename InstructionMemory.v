
`include "DEFINE.v"
module InstructionMemory(
	input wire [`INST_ADDR_BUS] rom_addr_i,
	input wire rom_ce_i,
	output wire [`INST_BUS] rom_data_o
);
	
	assign rom_data_o=	(rom_ce_i==`CHIP_DISABLE)?`ZERO_WORD:
						(rom_addr_i==32'h0000_0000)?32'h24010000:
						(rom_addr_i==32'h0000_0004)?32'hac210000:
						(rom_addr_i==32'h0000_0008)?32'h24220004:
						(rom_addr_i==32'h0000_000C)?32'hac420000:
						(rom_addr_i==32'h0000_0010)?32'h24230008:
						(rom_addr_i==32'h0000_0014)?32'h24630004:
						(rom_addr_i==32'h0000_0018)?32'h24630004:
						(rom_addr_i==32'h0000_001C)?32'h24630004:
						(rom_addr_i==32'h0000_0020)?32'h2463fff4:
						(rom_addr_i==32'h0000_0024)?32'hac630000:
						(rom_addr_i==32'h0000_0028)?32'h2404000c:
						(rom_addr_i==32'h0000_002C)?32'hac840000:
						(rom_addr_i==32'h0000_0030)?32'h24050010:
						(rom_addr_i==32'h0000_0034)?32'haca50000:
						(rom_addr_i==32'h0000_0038)?32'h24060014:
						(rom_addr_i==32'h0000_003C)?32'hacc60000:
						(rom_addr_i==32'h0000_0040)?32'h8c270000:
						(rom_addr_i==32'h0000_0044)?32'h8ce70004:
						(rom_addr_i==32'h0000_0048)?32'h8ce70004:
						(rom_addr_i==32'h0000_004C)?32'h8ce70004:
						(rom_addr_i==32'h0000_0050)?32'h8ce70004:
						(rom_addr_i==32'h0000_0054)?32'h8ce70004:
						(rom_addr_i==32'h0000_0058)?32'h10e60000:
						(rom_addr_i==32'h0000_005C)?32'h8ce80000:
						(rom_addr_i==32'h0000_0060)?32'hac080018:
						(rom_addr_i==32'h0000_0064)?32'h8c090018:
						(rom_addr_i==32'h0000_0068)?32'hac09001c:
						(rom_addr_i==32'h0000_006C)?32'h0800001c:
						(rom_addr_i==32'h0000_0070)?32'h240a0888:
						`ZERO_WORD;
endmodule
