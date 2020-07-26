
module RegisterFile(reset, clk, RegWrite, Read_Register_1, Read_Register_2, Write_Register, Write_Data, Read_Data_1, Read_Data_2);
	input reset, clk;
	input RegWrite;
	input [4:0] Read_Register_1, Read_Register_2, Write_Register;
	input [31:0] Write_Data;
	output [31:0] Read_Data_1, Read_Data_2;
	
	reg [31:0] RF_data[31:1];
	
	assign Read_Data_1 = (Read_Register_1 == 5'b00000)? 32'h00000000: RF_data[Read_Register_1];
	assign Read_Data_2 = (Read_Register_2 == 5'b00000)? 32'h00000000: RF_data[Read_Register_2];
	
	integer i;
	always @(posedge reset or posedge clk)
		if (reset)
			for (i = 1; i < 32; i = i + 1)
				RF_data[i] <= 32'h00000000;
		else if (RegWrite && (Write_Register != 5'b00000))
			RF_data[Write_Register] <= Write_Data;

endmodule
			