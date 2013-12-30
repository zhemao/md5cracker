module gcalc (
    input  [5:0] i,
    output [3:0] g
);

reg  [2:0] scale;
reg  [2:0] addon;
wire [3:0] mult_res;

assign g = mult_res + addon;

minimult mm (
    .dataa (i[3:0]),
    .datab (scale),
    .result (mult_res)
);

always @(*) begin
    case (i[5:4])
        2'b00: begin
            scale <= 3'd1;
            addon <= 3'd0;
        end
        2'b01: begin
            scale <= 3'd5;
            addon <= 3'd1;
        end
        2'b10: begin
            scale <= 3'd3;
            addon <= 3'd5;
        end
        2'b11: begin
            scale <= 3'd7;
            addon <= 3'd0;
        end
    endcase
end

endmodule
