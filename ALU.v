
module ALU(In1, In2, ALUCtl, Sign, Out);
	input [31:0] In1, In2;
	input [4:0] ALUCtl;
	input Sign;
	output reg [31:0] Out;
	
	wire ss;
	assign ss = {In1[31], In2[31]};
	
	wire lt_31;
	assign lt_31 = (In1[30:0] < In2[30:0]);
	
	wire lt_signed;
	assign lt_signed = (In1[31] ^ In2[31])? 
		((ss == 2'b01)? 0: 1): lt_31;
	
	always @(*)
		case (ALUCtl)
			5'b00000: Out = In1 & In2;
			5'b00001: Out = In1 | In2;
			5'b00010: Out = In1 + In2;
			5'b00110: Out = In1 - In2;
			5'b00111: Out = {31'h00000000, Sign? lt_signed: (In1 < In2)};
			5'b01100: Out = ~(In1 | In2);
			5'b01101: Out = In1 ^ In2;
			5'b10000: Out = (In2 << In1[4:0]);
			5'b11000: Out = (In2 >> In1[4:0]);
			5'b11001: Out = ({{32{In2[31]}}, In2} >> In1[4:0]);
			default: Out <= 32'h00000000;
		endcase
	
endmodule