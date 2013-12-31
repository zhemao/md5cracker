module md5unit_tb ();

// little endian, so the actual string is
// 08 02 68 01 bb 80 ab 13 30 2c 8b cb 82 75 65 b9 48 3c 79 a3 be 26 3f 10 c4 da 78 0b 48 33 43 5c 87 92 e9 4d 7c be f0 ef 33 85
parameter teststring = 512'h0000002a0000000000000000000000000000000000808533eff0be7c4de992875c4333480b78dac4103f26bea3793c48b9657582cb8b2c3013ab80bb01680208;
parameter expected = 128'hbaebddf861d3eb2714ba892c2ad26682;

reg [3:0] writeaddr;
wire [31:0] writedata = teststring[writeaddr * 32 + 31: writeaddr * 32];
reg write;
reg clk = 1'b1;
reg reset;
reg start;
wire [127:0] digest;
wire done;

md5unit md5 (
    .clk (clk),
    .reset ({1'b0, reset}),
    .start ({1'b0, start}),
    .write (write),
    .writedata (writedata),
    .writeaddr ({1'b0, writeaddr}),
    .digest0 (digest),
    .done (done)
);

always begin
    #10000 clk = !clk;
end

integer i;
initial begin
    reset = 1'b1;
    write = 1'b0;
    start = 1'b0;
    writeaddr = 4'h0;
    #20000 reset = 1'b0;
    write = 1'b1;

    for (i = 1; i < 16; i = i + 1) begin
        #20000 writeaddr = i[3:0];
    end

    #20000 write = 1'b0;
    start = 1'b1;
    #20000 start = 1'b0;

    #5240000 assert(done);
    assert(digest == expected);
end

endmodule
