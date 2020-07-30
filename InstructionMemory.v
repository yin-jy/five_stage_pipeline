
`include "DEFINE.v"
module InstructionMemory(
	input wire [`INST_ADDR_BUS] rom_addr_i,
	input wire rom_ce_i,
	output wire [`INST_BUS] rom_data_o
);
	
	assign rom_data_o=	(rom_ce_i==`CHIP_DISABLE)?`ZERO_WORD:
						(rom_addr_i==32'h0000_0000)?32'h34018000:
						(rom_addr_i==32'h0000_0004)?32'h00010c00:
						(rom_addr_i==32'h0000_0008)?32'h34210010:
						(rom_addr_i==32'h0000_000C)?32'h10210004:
						(rom_addr_i==32'h0000_0010)?32'h34028000:
						(rom_addr_i==32'h0000_0014)?32'h00021400:
						(rom_addr_i==32'h0000_0018)?32'h34420001:
						(rom_addr_i==32'h0000_001C)?32'h18400005:
						(rom_addr_i==32'h0000_0020)?32'h34030000:
						(rom_addr_i==32'h0000_0024)?32'h00411821:
						(rom_addr_i==32'h0000_0028)?32'h34030000:
						(rom_addr_i==32'h0000_002C)?32'h00411820:
						(rom_addr_i==32'h0000_0030)?32'h1443fff7:
						(rom_addr_i==32'h0000_0034)?32'h00231822:
						(rom_addr_i==32'h0000_0038)?32'h00621823:
						(rom_addr_i==32'h0000_003C)?32'h0c000013:
						(rom_addr_i==32'h0000_0040)?32'h24630002:
						(rom_addr_i==32'h0000_0044)?32'h34030000:
						(rom_addr_i==32'h0000_0048)?32'h08000018:
						(rom_addr_i==32'h0000_004C)?32'h3401ffff:
						(rom_addr_i==32'h0000_0050)?32'h00010c00:
						(rom_addr_i==32'h0000_0054)?32'h0020102a:
						(rom_addr_i==32'h0000_0058)?32'h0020102b:
						(rom_addr_i==32'h0000_005C)?32'h03e00008:
						(rom_addr_i==32'h0000_0060)?32'h34010001:
						(rom_addr_i==32'h0000_0064)?32'h34210002:
						(rom_addr_i==32'h0000_0068)?32'h34210004:
						`ZERO_WORD;
endmodule
