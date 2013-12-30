module chunk_cruncher (
    input clk,
    input reset,
    output done,

    input [31:0] a0,
    input [31:0] b0,
    input [31:0] c0,
    input [31:0] d0,

    output [31:0] a1,
    output [31:0] b1,
    output [31:0] c1,
    output [31:0] d1,

    output [5:0]  iaddr,
    input  [31:0] kdata,
    input  [4:0]  sdata,

    output [3:0]  gaddr,
    input  [31:0] mdata
);

reg [31:0] areg;
reg [31:0] breg;
reg [31:0] creg;
reg [31:0] dreg;

assign a1 = areg;
assign b1 = breg;
assign c1 = creg;
assign d1 = dreg;

reg [5:0] ireg;

wire [31:0] f;
reg  [31:0] freg;

reg  [31:0] adda;
reg  [31:0] addb;
wire [31:0] adds = adda + addb;

reg [31:0] t0;
reg [31:0] t1;

wire [31:0] rotated;

assign iaddr = ireg;

fcalc fc (
    .sel (ireg[5:4]),
    .b (b),
    .c (c),
    .d (d),
    .f (f)
);

gcalc gc (
    .i (ireg),
    .g (gaddr)
);

leftrotate lr (
    .rotin (t0),
    .rotby (sdata),
    .rotout (rotated)
);

reg [1:0] step;

assign done = (step == 2'b11) && (ireg == 6'd63);

always @(*) begin
    case (step)
        2'b00: begin
            adda <= areg;
            addb <= kdata;
        end
        2'b01: begin
            adda <= freg;
            addb <= mdata;
        end
        2'b10: begin
            adda <= t0;
            addb <= t1;
        end
        2'b11: begin
            adda <= breg;
            addb <= rotated;
        end
    endcase
end

always @(posedge clk) begin
    if (reset) begin
        areg <= a0;
        breg <= b0;
        creg <= c0;
        dreg <= d0;
        ireg <= 6'd0;
        step <= 2'b00;
    end else case (step)
        2'b00: begin
            freg <= f;
            t0 <= adds;
        end
        2'b01: t1 <= adds;
        2'b10: t0 <= adds;
        2'b11: if (ireg != 6'd63) begin
            areg <= dreg;
            breg <= adds;
            creg <= breg;
            dreg <= creg;
            ireg <= ireg + 1'b1;
        end
    endcase
end

endmodule
