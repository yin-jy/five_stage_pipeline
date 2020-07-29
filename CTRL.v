
`include "DEFINE.v"
module CTRL(
    input wire rst,
    input wire id_stallreq_i,
    input wire ex_stallreq_i,
    output wire [`STALL_BUS] stall_o
);

    assign stall_o= (rst==`RST_ENABLE)?`NO_STALL:
                    (ex_stallreq_i==`STALLREQ_ENABLE)?`EX_STALL:
                    (id_stallreq_i==`STALLREQ_ENABLE)?`ID_STALL:`NO_STALL;

endmodule