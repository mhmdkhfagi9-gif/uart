
module fsm (
    input wire clk,
    input wire rst,
    input wire parity_en,
    input wire valid_in,
    output reg load_en,
    output reg shift_en,
    output reg busy,
    output reg [1:0] sel
);

    reg [2:0] current_state, next_state;
    reg [2:0] count;

    localparam S0     = 3'b000,
               START  = 3'b001,
               DATA   = 3'b010,
               PARITY = 3'b011,
               STOP   = 3'b100;

    always @(negedge clk or negedge rst) begin
        if (!rst) begin
            current_state <= S0;
            count         <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == DATA)
                count <= count + 1'b1;
            else
                count <= 3'b000;
        end
    end

    always @(*) begin
        load_en    = 1'b0;
        shift_en   = 1'b0;
        busy       = 1'b1;
        sel        = 2'b11;
        next_state = current_state;

        case (current_state)
            S0: begin 
                busy = 1'b0;
                if (valid_in) begin 
                    load_en    = 1'b1;
                    next_state = START;
                end else begin
                    next_state = S0;
                end
            end

            START: begin 
                sel        = 2'b00;
                next_state = DATA;
            end

            DATA: begin 
                sel      = 2'b01;
                shift_en = 1'b1;
                if (count != 3'd7) begin
                    next_state = DATA;
                end else begin
                    if (parity_en)
                        next_state = PARITY;
                    else
                        next_state = STOP;
                end
            end

            PARITY: begin 
                sel        = 2'b10;
                next_state = STOP;
            end

            STOP: begin 
                sel        = 2'b11;
                next_state = S0;
            end

            default: next_state = S0;
        endcase
    end

endmodule