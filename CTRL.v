
`include "DEFINE.v"
module CTRL(
    input wire rst,
    input wire id_jbstallreq_i,
    input wire id_lwstallreq_i,
    input wire ex_stallreq_i,
    input wire peri_intreq_i,
    output wire [`STALL_BUS] stall_o
);

    assign stall_o= (rst==`RST_ENABLE)?`NO_STALL:
                    (peri_intreq_i==`STALLREQ_ENABLE)?`JB_STALL:
                    (ex_stallreq_i==`STALLREQ_ENABLE)?`EX_STALL:
                    (id_lwstallreq_i==`STALLREQ_ENABLE)?`LW_STALL:
                    (id_jbstallreq_i==`STALLREQ_ENABLE)?`JB_STALL:`NO_STALL;

endmodule