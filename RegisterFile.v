
`include "DEFINE.v"
module RegisterFile(
	input wire rst,
	input wire clk,
	//from wb
	input wire we,
	input wire [`REG_ADDR_BUS] waddr,
	input wire [`REG_BUS] wdata,
	//from id
	input wire re1,
	input wire [`REG_ADDR_BUS] raddr1,
	output wire [`REG_BUS] rdata1,
	//from id
	input wire re2,
	input wire [`REG_ADDR_BUS] raddr2,
	output wire [`REG_BUS] rdata2
);

	reg [`REG_BUS] regs[`REG_NUM-1:1];

	assign rdata1=	(rst==`RST_ENABLE)?`ZERO_WORD:
					(raddr1==`REG_NUM_LOG2'h0)?`ZERO_WORD:
					((raddr1==waddr)&&(we==`WR_ENABLE)&&(re1==`RD_ENABLE))?wdata:
					(re1==`RD_ENABLE)?regs[raddr1]:`ZERO_WORD;
	assign rdata2=	(rst==`RST_ENABLE)?`ZERO_WORD:
					(raddr2==`REG_NUM_LOG2'h0)?`ZERO_WORD:
					((raddr2==waddr)&&(we==`WR_ENABLE)&&(re2==`RD_ENABLE))?wdata:
					(re2==`RD_ENABLE)?regs[raddr2]:`ZERO_WORD;
	
	integer i;
	always @(posedge clk)
		if (rst==`RST_ENABLE)
			for (i=1; i<`REG_NUM; i=i+1)
				regs[i]<=`ZERO_WORD;
		else if ((we==`WR_ENABLE)&&(waddr!=`REG_NUM_LOG2'b0))
			regs[waddr]<=wdata;

endmodule
			