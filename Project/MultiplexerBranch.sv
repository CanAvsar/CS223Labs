module MultiplexerBranch(
    input logic controlInput,
    input logic a, b,
    output logic out);

always_comb
    begin
        case (controlInput)
            0: out = a;
            1: out = b;
        endcase
    end
endmodule