module md5cracker (
    input clock_50,
    output [3:0] leds
);

chunk_cruncher cc (
    .clk (clock_50)
);

endmodule