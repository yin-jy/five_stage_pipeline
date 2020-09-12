
`include "DEFINE.v"
module PeripheralControl(
    input wire rst,
    input wire clk,
    
    input wire peri_cre_i,
    input wire peri_cwe_i,
    input wire [`MEM_ADDR_BUS] peri_addr_i,
    input wire [`MEM_BUS] peri_wdata_i,
    input wire peri_pc31_i,
    output wire [`MEM_BUS] peri_rdata_o,
    output wire intreq_o
);

	reg [31:0] TH;
    reg [31:0] TL;
    reg [2:0] TCON;

    reg [7:0] LED;

    reg [11:0] DIGITAL;
    
    reg [31:0] SYSTICK;

    assign peri_rdata_o=(rst==`RST_ENABLE)?`ZERO_WORD:
                        (peri_cre_i==`RD_DISABLE)?`ZERO_WORD:
                        (peri_addr_i==32'h4000_0000)?TH:
                        (peri_addr_i==32'h4000_0004)?TL:
                        (peri_addr_i==32'h4000_0008)?{29'b0,TCON}:
                        (peri_addr_i==32'h4000_000C)?{24'b0,LED}:
                        (peri_addr_i==32'h4000_0010)?{20'b0,DIGITAL}:
                        (peri_addr_i==32'h4000_0014)?SYSTICK:`ZERO_WORD;
    assign intreq_o=TCON[2];
	
    integer i;
	always @(posedge clk) begin
		if (rst==`RST_ENABLE) begin
            TH<=`ZERO_WORD;
            TL<=`ZERO_WORD;
            TCON<={`TIMER_CNT_STATUS,`INT_DISABLE,`TIMER_DISABLE};
            LED<=8'b0000_0000;
            DIGITAL<=12'b0000_0000_0000;
            SYSTICK<=`ZERO_WORD;
        end else begin
            TH<=(peri_cwe_i==`WR_ENABLE)&&(peri_addr_i==32'h4000_0000)?peri_wdata_i:TH;
            TL<=(peri_cwe_i==`WR_ENABLE)&&(peri_addr_i==32'h4000_0004)?peri_wdata_i:
                (TCON[0]==`TIMER_DISABLE)?TL:
                (TL==`TL_FULL_WORD)?TH:TL+32'h0000_0001;
            TCON[2]<=   (peri_cwe_i==`WR_ENABLE)&&(peri_addr_i==32'h4000_0008)?peri_wdata_i[2]:   
                        (TCON[0]==`TIMER_DISABLE)||(TCON[1]==`INT_DISABLE)?TCON[2]:
                        (TL==`TL_FULL_WORD)&&(peri_pc31_i==`USER_STATE)?`TIMER_INT_STATUS:`TIMER_CNT_STATUS;
            TCON[1]<=(peri_cwe_i==`WR_ENABLE)&&(peri_addr_i==32'h4000_0008)?peri_wdata_i[1]:TCON[1];
            TCON[0]<=(peri_cwe_i==`WR_ENABLE)&&(peri_addr_i==32'h4000_0008)?peri_wdata_i[0]:TCON[0];
            LED<=(peri_cwe_i==`WR_ENABLE)&&(peri_addr_i==32'h4000_000C)?peri_wdata_i[7:0]:LED;
            DIGITAL<=(peri_cwe_i==`WR_ENABLE)&&(peri_addr_i==32'h4000_0010)?peri_wdata_i[11:0]:DIGITAL;
            SYSTICK<=SYSTICK+32'h0000_0001;
        end
    end

endmodule
