module part4(SW, HEX0);
input [1:0] SW;
output reg[0:6] HEX0;
//these are all active low enable 
always @(*) begin
  case (SW[1:0])
    2'b00: HEX0= 7'b1000010;
    2'b01: HEX0= 7'b0110000;
    2'b10: HEX0= 7'b1001111;
    default:
        HEX0 = 7'b1111111;
  endcase
end

endmodule