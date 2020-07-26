
module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			// addi $a0, $zero, 12345 #(0x3039)
			8'd0:    Instruction = {6'h08, 5'd0 , 5'd4 , 16'h3039};	
			default: Instruction = 32'h00000000;
		endcase
		
endmodule
