module md5cracker (
    input clock_50,
    output [3:0] leds
);

md5unit md5 (
    .clk (clock_50),
    .reset (2'b00),
    .start (2'b00),

    .write (1'b0),
    .writedata (31'd0),
    .writeaddr (5'd0)
);

endmodule
