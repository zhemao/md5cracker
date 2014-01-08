module md5control (
    input clk,
    input reset,

    input      [31:0] avs_writedata,
    output reg [31:0] avs_readdata,
    input      [1:0]  avs_address,
    input             avs_read,
    input             avs_write,

    output [31:0] md5_start,
    output [31:0] md5_reset,
    input  [31:0] md5_done
);

reg [31:0] start_reg;
reg [31:0] reset_reg;

assign md5_start = start_reg;
assign md5_reset = reset_reg;

always @(posedge clk) begin
    start_reg <= 32'd0;
    reset_reg <= 32'd0;
    if (avs_write) begin
        case (avs_address)
            2'b00: reset_reg <= avs_writedata;
            2'b01: start_reg <= avs_writedata;
        endcase
    end else if (avs_read) begin
        case (avs_address)
            2'b00: avs_readdata <= reset_reg;
            2'b01: avs_readdata <= start_reg;
            2'b10: avs_readdata <= md5_done;
            default: avs_readdata <= 32'd0;
        endcase
    end
end

endmodule
