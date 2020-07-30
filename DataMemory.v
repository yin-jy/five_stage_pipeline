
`include "DEFINE.v"
module DataMemory(
	input wire rst,
	input wire clk,

	input wire ram_cre_i,
	input wire ram_cwe_i,
	input wire [`MEM_ADDR_BUS] ram_addr_i,
	input wire [`MEM_BUS] ram_wdata_i,
	output wire [`MEM_BUS] ram_rdata_o
);
	
	reg [`MEM_BUS] RAM_data [`RAM_WORDS-1:0];
	assign ram_rdata_o=	(rst==`RST_ENABLE)?`ZERO_WORD:
						(ram_cre_i==`RD_ENABLE)?RAM_data[ram_addr_i[10:2]]:`ZERO_WORD;
	
	integer i;
	always @(posedge clk)
		if(rst==`RST_ENABLE)
			for (i=0;i<`RAM_WORDS;i=i+1)
				RAM_data[i]<=`ZERO_WORD;
		else if(ram_cwe_i==`WR_ENABLE)
			RAM_data[ram_addr_i[10:2]]<=ram_wdata_i;
		else ;
			
endmodule
