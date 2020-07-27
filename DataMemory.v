
module DataMemory(rst, clk, Address, Write_Data, Read_Data, DataMemory_Read, DataMemory_Write);
	input rst, clk;
	input [31:0] Address, Write_Data;
	input DataMemory_Read, DataMemory_Write;
	output [31:0] Read_Data;
	
	parameter RAM_SIZE = 1024;
	parameter RAM_SIZE_BIT = 8;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	assign Read_Data = DataMemory_Read? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	
	integer i;
	always @(posedge rst or posedge clk)
		if (rst)
			for (i = 0; i < RAM_SIZE; i = i + 1)
				RAM_data[i] <= 32'h00000000;
		else if (DataMemory_Write)
			RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_Data;
			
endmodule
