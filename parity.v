
module parity (
    input  wire       parity_en,
    input  wire       parity_bit,
    input  wire [7:0] data,
    output reg        parity_out
);

    always @(*) begin 
        if (parity_en) begin
            if (!parity_bit) begin
                if (^data == 1'b1) 
                    parity_out = 1'b1;
                else 
                    parity_out = 1'b0;
            end else begin
                if (^data == 1'b0) 
                    parity_out = 1'b1;
                else 
                    parity_out = 1'b0;
            end
        end else begin
            parity_out = 1'b0;
        end
    end

endmodule