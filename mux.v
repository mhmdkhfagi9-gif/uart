module mux(
    input wire data,
    input wire parity_out,
    input wire [1:0] sel,
    output reg  tx_out
);
always @(*) begin 
case(sel)  
2'b00: begin 
tx_out = 1'b0;
end
2'b01: begin 
tx_out = data;
end
2'b10: begin 
tx_out = parity_out;
end
2'b11: begin 
tx_out =1'b1;
end
default : tx_out =1'b1;



endcase
end
endmodule