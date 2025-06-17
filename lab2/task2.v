module lab1(SW, HEX0, HEX1);
input[9:0]SW;
output  [0:6]HEX0;
output reg [0:6]HEX1;
reg [3:0] val1;
wire z;

comp4Bit(.value(SW[3:0]), .valid(z));

seven_segment_decoder(.digit(val1), .seg(HEX0));
always @(*) begin
  if(z==1'b0) begin
    val1 = SW[3:0];

	     HEX1= 7'b0000001;
  end else begin
    val1= SW[3:0] - 4'b1010;
       HEX1= 7'b1001111;	
  end

end

endmodule

module comp4Bit(value, valid);
input[3:0] value;
output reg valid;
always @(*) begin
if (value > 4'b1001) begin
    valid = 1'b1;
end
else begin 
    valid= 1'b0;
end
end

endmodule


module seven_segment_decoder (
    input  [3:0] digit,
    output reg [0:6] seg // a b c d e f g 
);

always @(*) begin
    case (digit)
        4'd0: seg = 7'b0000001;
        4'd1: seg = 7'b1001111;
        4'd2: seg = 7'b0010010;
        4'd3: seg = 7'b0000110;
        4'd4: seg = 7'b1001100;
        4'd5: seg = 7'b0100100;
        4'd6: seg = 7'b0100000;
        4'd7: seg = 7'b0001111;
        4'd8: seg = 7'b0000000;
        4'd9: seg = 7'b0000100;
        default: seg = 7'b1111111; // all segments off
    endcase
end

endmodule
