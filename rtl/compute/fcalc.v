module fcalc (
    input [1:0] sel,
    input [31:0] b,
    input [31:0] c,
    input [31:0] d,
    output reg [31:0] f
);

always @(*) begin
    case (sel)
        2'b00: f <= (b & c) | (~b & d);
        2'b01: f <= (d & b) | (~d & c);
        2'b10: f <= b ^ c ^ d;
        2'b11: f <= c ^ (b | ~d);
    endcase
end

endmodule
