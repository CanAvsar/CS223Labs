module Multiplexer(
    input logic controlInput,
    input logic [7:0] a, b,
    output logic [7:0] out);

always_comb
    begin
        case (controlInput)
            0: out = a;
            1: out = b;
        endcase
    end
endmodule