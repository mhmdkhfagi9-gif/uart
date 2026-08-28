`timescale 1ns/1ps

module uart_tx_tb;

    reg        clk;
    reg        rst;
    reg        parity_bit;
    reg        parity_en;
    reg        valid_in;
    reg  [7:0] p_data;

    wire       tx_out;
    wire       busy;

    uart_tx_top uut (
        .clk        (clk),
        .rst        (rst),
        .parity_bit (parity_bit),
        .parity_en  (parity_en),
        .valid_in   (valid_in),
        .p_data     (p_data),
        .tx_out     (tx_out),
        .busy       (busy)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("uart_tx.vcd");
        $dumpvars(0, uart_tx_tb);

        clk        = 0;
        rst        = 0;
        parity_bit = 0;
        parity_en  = 0;
        valid_in   = 0;
        p_data     = 8'h00;

        #20;
        rst = 1;
        #20;

        p_data     = 8'b10100101; 
        parity_en  = 1'b1;
        parity_bit = 1'b0;
        valid_in   = 1'b1;
        #10;
        valid_in   = 1'b0;

        wait (busy == 1'b1);
        wait (busy == 1'b0);
        #20;

        p_data     = 8'b00111100; 
        parity_en  = 1'b1;
        parity_bit = 1'b1;
        valid_in   = 1'b1;
        #10;
        valid_in   = 1'b0;

        wait (busy == 1'b1);
        wait (busy == 1'b0);
        #20;

        p_data     = 8'b11111111; 
        parity_en  = 1'b0;
        valid_in   = 1'b1;
        #10;
        valid_in   = 1'b0;

        wait (busy == 1'b1);
        wait (busy == 1'b0);
        #20;

        p_data     = 8'b01010101;
        parity_en  = 1'b1;
        parity_bit = 1'b0;
        valid_in   = 1'b1;
        #10;
        valid_in   = 1'b0;

        wait (busy == 1'b1);
        wait (busy == 1'b0);
        
        p_data     = 8'b11001100;
        valid_in   = 1'b1;
        #10;
        valid_in   = 1'b0;

        wait (busy == 1'b1);
        wait (busy == 1'b0);
        #50;

        $stop;
    end

endmodule
