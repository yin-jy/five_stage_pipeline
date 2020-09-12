
`include "DEFINE.v"
module InstructionMemory(
	input wire [`INST_ADDR_BUS] rom_addr_i,
	input wire rom_ce_i,
	output wire [`INST_BUS] rom_data_o
);
	
	assign rom_data_o=	(rom_ce_i==`CHIP_DISABLE)?`ZERO_WORD:
						(rom_addr_i==32'h0000_0000)?32'h08000003:
						(rom_addr_i==32'h0000_0004)?32'h08000010:
						(rom_addr_i==32'h0000_0008)?32'h08000021:
						(rom_addr_i==32'h0000_000C)?32'h34091111:
						(rom_addr_i==32'h0000_0010)?32'h34092222:
						(rom_addr_i==32'h0000_0014)?32'h34093333:
						(rom_addr_i==32'h0000_0018)?32'h34094444:
						(rom_addr_i==32'h0000_001C)?32'h34091111:
						(rom_addr_i==32'h0000_0020)?32'h34092222:
						(rom_addr_i==32'h0000_0024)?32'h34093333:
						(rom_addr_i==32'h0000_0028)?32'h34094444:
						(rom_addr_i==32'h0000_002C)?32'h34091111:
						(rom_addr_i==32'h0000_0030)?32'h34092222:
						(rom_addr_i==32'h0000_0034)?32'h34093333:
						(rom_addr_i==32'h0000_0038)?32'h34094444:
						(rom_addr_i==32'h0000_003C)?32'h08000032:
						(rom_addr_i==32'h0000_0040)?32'h3c014000:
						(rom_addr_i==32'h0000_0044)?32'h34210000:
						(rom_addr_i==32'h0000_0048)?32'h00014020:
						(rom_addr_i==32'h0000_004C)?32'h8d090008:
						(rom_addr_i==32'h0000_0050)?32'h3c01ffff:
						(rom_addr_i==32'h0000_0054)?32'h3421fff9:
						(rom_addr_i==32'h0000_0058)?32'h01214824:
						(rom_addr_i==32'h0000_005C)?32'had090008:
						(rom_addr_i==32'h0000_0060)?32'h34095555:
						(rom_addr_i==32'h0000_0064)?32'h34096666:
						(rom_addr_i==32'h0000_0068)?32'h3c014000:
						(rom_addr_i==32'h0000_006C)?32'h34210000:
						(rom_addr_i==32'h0000_0070)?32'h00014020:
						(rom_addr_i==32'h0000_0074)?32'h8d090008:
						(rom_addr_i==32'h0000_0078)?32'h35290002:
						(rom_addr_i==32'h0000_007C)?32'had090008:
						(rom_addr_i==32'h0000_0080)?32'h03400008:
						(rom_addr_i==32'h0000_0084)?32'h3c014000:
						(rom_addr_i==32'h0000_0088)?32'h34210000:
						(rom_addr_i==32'h0000_008C)?32'h00014020:
						(rom_addr_i==32'h0000_0090)?32'h8d090008:
						(rom_addr_i==32'h0000_0094)?32'h3c01ffff:
						(rom_addr_i==32'h0000_0098)?32'h3421fff9:
						(rom_addr_i==32'h0000_009C)?32'h01214824:
						(rom_addr_i==32'h0000_00A0)?32'had090008:
						(rom_addr_i==32'h0000_00A4)?32'h34095555:
						(rom_addr_i==32'h0000_00A8)?32'h34096666:
						(rom_addr_i==32'h0000_00AC)?32'h3c014000:
						(rom_addr_i==32'h0000_00B0)?32'h34210000:
						(rom_addr_i==32'h0000_00B4)?32'h00014020:
						(rom_addr_i==32'h0000_00B8)?32'h8d090008:
						(rom_addr_i==32'h0000_00BC)?32'h35290002:
						(rom_addr_i==32'h0000_00C0)?32'had090008:
						(rom_addr_i==32'h0000_00C4)?32'h03400008:
						(rom_addr_i==32'h0000_00C8)?32'h0c000036:
						(rom_addr_i==32'h0000_00CC)?32'h34097777:
						(rom_addr_i==32'h0000_00D0)?32'h34098888:
						(rom_addr_i==32'h0000_00D4)?32'h08000033:
						(rom_addr_i==32'h0000_00D8)?32'h3c017fff:
						(rom_addr_i==32'h0000_00DC)?32'h3421ffff:
						(rom_addr_i==32'h0000_00E0)?32'h03e1f824:
						(rom_addr_i==32'h0000_00E4)?32'h3c014000:
						(rom_addr_i==32'h0000_00E8)?32'h34210000:
						(rom_addr_i==32'h0000_00EC)?32'h00014020:
						(rom_addr_i==32'h0000_00F0)?32'had000008:
						(rom_addr_i==32'h0000_00F4)?32'h2009fffd:
						(rom_addr_i==32'h0000_00F8)?32'had090000:
						(rom_addr_i==32'h0000_00FC)?32'had090004:
						(rom_addr_i==32'h0000_0100)?32'h20090003:
						(rom_addr_i==32'h0000_0104)?32'had090008:
						(rom_addr_i==32'h0000_0108)?32'h03e00008:
						`ZERO_WORD;
endmodule
