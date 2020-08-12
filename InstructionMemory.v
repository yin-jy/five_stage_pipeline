
`include "DEFINE.v"
module InstructionMemory(
	input wire [`INST_ADDR_BUS] rom_addr_i,
	input wire rom_ce_i,
	output wire [`INST_BUS] rom_data_o
);
	
	assign rom_data_o=	(rom_ce_i==`CHIP_DISABLE)?`ZERO_WORD:
						(rom_addr_i==32'h0000_0000)?32'h34014000:
						(rom_addr_i==32'h0000_0004)?32'h00010c00:
						(rom_addr_i==32'h0000_0008)?32'h34210000:
						(rom_addr_i==32'h0000_000C)?32'h34024000:
						(rom_addr_i==32'h0000_0010)?32'h00021400:
						(rom_addr_i==32'h0000_0014)?32'h34420004:
						(rom_addr_i==32'h0000_0018)?32'h34034000:
						(rom_addr_i==32'h0000_001C)?32'h00031c00:
						(rom_addr_i==32'h0000_0020)?32'h34630008:
						(rom_addr_i==32'h0000_0024)?32'h34044000:
						(rom_addr_i==32'h0000_0028)?32'h00042400:
						(rom_addr_i==32'h0000_002C)?32'h3484000c:
						(rom_addr_i==32'h0000_0030)?32'h34054000:
						(rom_addr_i==32'h0000_0034)?32'h00052c00:
						(rom_addr_i==32'h0000_0038)?32'h34a50010:
						(rom_addr_i==32'h0000_003C)?32'h34064000:
						(rom_addr_i==32'h0000_0040)?32'h00063400:
						(rom_addr_i==32'h0000_0044)?32'h34c60014:
						(rom_addr_i==32'h0000_0048)?32'h2407fffa:
						(rom_addr_i==32'h0000_004C)?32'hac270000:
						(rom_addr_i==32'h0000_0050)?32'h2407ffff:
						(rom_addr_i==32'h0000_0054)?32'hac470000:
						(rom_addr_i==32'h0000_0058)?32'h24070003:
						(rom_addr_i==32'h0000_005C)?32'hac670000:
						(rom_addr_i==32'h0000_0060)?32'h24070101:
						(rom_addr_i==32'h0000_0064)?32'hac870000:
						(rom_addr_i==32'h0000_0068)?32'h24071001:
						(rom_addr_i==32'h0000_006C)?32'haca70000:
						(rom_addr_i==32'h0000_0070)?32'h8c870000:
						(rom_addr_i==32'h0000_0074)?32'h8ca70000:
						(rom_addr_i==32'h0000_0078)?32'h8cc70000:
						(rom_addr_i==32'h0000_007C)?32'h8cc70000:
						(rom_addr_i==32'h0000_0080)?32'h8cc70000:
						`ZERO_WORD;
endmodule
