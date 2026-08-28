module serializer (
    input  wire       clk,
    input  wire       rst,
    input  wire       load_en,
    input  wire       shift_en,
    input  wire [7:0] data,
    output wire       ser_data
);

    reg [7:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            shift_reg <= 8'b0;
        end else if (load_en) begin
            shift_reg <= data;
        end else if (shift_en) begin
            shift_reg <= shift_reg >> 1;
        end
    end

    assign ser_data = shift_reg[0];

endmodule
