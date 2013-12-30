module gcalc (
    input  [5:0] i,
    output [3:0] g
);

reg doshift;
reg sub;
reg  [1:0] shiftby;
reg  [2:0] addon;

wire [3:0] shift_res = (doshift) ? i[3:0] << shiftby : 4'b0;
wire [3:0] mult_res = (sub) ? shift_res - i[3:0] : shift_res + i[3:0];
assign g = mult_res + addon;

always @(*) begin
    case (i[5:4])
        2'b00: begin
            doshift <= 1'b0;
            sub <= 1'b0;
            shiftby <= 2'b0;
            addon <= 3'd0;
        end
        2'b01: begin
            doshift <= 1'b1;
            sub <= 1'b0;
            shiftby <= 2'b10;
            addon <= 3'd1;
        end
        2'b10: begin
            doshift <= 1'b1;
            sub <= 1'b0;
            shiftby <= 2'b01;
            addon <= 3'd5;
        end
        2'b11: begin
            doshift <= 1'b1;
            sub <= 1'b1;
            shiftby <= 2'b11;
            addon <= 3'd0;
        end
    endcase
end

endmodule
