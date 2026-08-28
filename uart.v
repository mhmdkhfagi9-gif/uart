
module uart_tx_top (
    input  wire       clk,
    input  wire       rst,
    input  wire       parity_bit,
    input  wire       parity_en,
    input  wire       valid_in,
    input  wire [7:0] p_data,
    output wire       tx_out,
    output wire       busy
);

    wire       ser_data_internal;
    wire       parity_out_internal;
    wire       load_en_internal;
    wire       shift_en_internal;
    wire [1:0] sel_internal;

    serializer A_serializer (
        .clk      (clk),                
        .rst      (rst),               
        .data     (p_data),             
        .load_en  (load_en_internal),   
        .shift_en (shift_en_internal),  
        .ser_data (ser_data_internal)   
    );

    parity A_parity (
        .parity_en  (parity_en),
        .parity_bit (parity_bit),
        .data       (p_data),
        .parity_out (parity_out_internal)
    );

    mux A_mux (
        .data       (ser_data_internal),
        .parity_out (parity_out_internal),
        .sel        (sel_internal),
        .tx_out     (tx_out)
    );

    fsm A_fsm (
        .clk        (clk),
        .rst        (rst),
        .parity_en  (parity_en),
        .valid_in   (valid_in),
        .load_en    (load_en_internal),
        .shift_en   (shift_en_internal),
        .busy       (busy),
        .sel        (sel_internal)
    );

endmodule