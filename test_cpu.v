`timescale 1ns/1ps
`include "DEFINE.v"
module test_cpu();
	
	reg rst;
	reg clk;
	wire [`INST_BUS] temp;

	TOP TOP0(.rst(rst),.clk(clk),.temp(temp));

	initial begin
		clk = 1'b0;
		forever #50 clk=~clk;
	end
	
	initial begin
		rst=`RST_ENABLE;
		#100 rst=`RST_DISABLE;
		#2000 $stop;
	end

endmodule
