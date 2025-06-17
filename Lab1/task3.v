module part3(SW, LEDR);
input [9:0] SW;
output reg [1:0] LEDR;

always @(*) begin
    case (SW[9:8])
        2'b00: LEDR = SW[1:0];
        2'b01: LEDR = SW[3:2];
        2'b10: LEDR = SW[5:4];
        2'b11: LEDR = SW[7:6];
        default: LEDR = 2'b00;
    endcase
end


endmodule