
module PeripheralControl(reset, clk, Address, Write_Data, Read_Data, PeripheralControl_Read, PeripheralControl_Write);
	input reset, clk;
	input [31:0] Address, Write_Data;
	input PeripheralControl_Read, PeripheralControl_Write;
	output reg [31:0] Read_Data;
	
    parameter RAM_SIZE = 16;
    parameter RAM_SIZE_BIT = 8;

	reg [31:0] TH;
    reg [31:0] TL;
    reg [2:0] TCON;

    reg [7:0] LED;

    reg [11:0] DIGITAL;
    
    reg [31:0] SYSTICK;

    always @(*) begin
        if(PeripheralControl_Read)
            case (Address)
                32'h4000_0000: Read_Data=TH;
                32'h4000_0004: Read_Data=TL;
                32'h4000_0008: Read_Data={29'b0,TCON};
                32'h4000_000C: Read_Data={24'b0,LED};
                32'h4000_0010: Read_Data={20'b0,DIGITAL};
                32'h4000_0014: Read_Data=SYSTICK;
                default: Read_Data=32'h0000_0000;
            endcase
    end
	
    integer i;
	always @(posedge reset or posedge clk) begin
		if (reset)
            SYSTICK<=32'h0000_0000;
		else begin
            SYSTICK<=SYSTICK+32'h0000_0001;
            if (TCON[0]) begin
                if (PeripheralControl_Write)
                    case(Address)
                        32'h4000_0008: TCON<=Write_Data[2:0];
                        32'h4000_000C: LED<=Write_Data[7:0];
                        32'h4000_0010: DIGITAL<=Write_Data[11:0];
                        default: ;
                    endcase
                if (TL==32'hFFFF_FFFF) begin
                    TL<=TH;
                    if(TCON[1]) TCON[2]<=1'b1;
                end
                else
                    TL<=TL+32'h0000_0001;
            end
            else begin
                if (PeripheralControl_Write)
                    case(Address)
                        32'h4000_0000: TH<=Write_Data;
                        32'h4000_0004: TL<=Write_Data;
                        32'h4000_0008: TCON<=Write_Data[2:0];
                        32'h4000_000C: LED<=Write_Data[7:0];
                        32'h4000_0010: DIGITAL<=Write_Data[11:0];
                        default: ;
                    endcase                
            end
        end
    end

endmodule
