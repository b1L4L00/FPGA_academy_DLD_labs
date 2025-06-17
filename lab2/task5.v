
module lab1(SW, LEDR, HEX0, HEX1, HEX3, HEX5);
input [9:0] SW;
output [9:0] LEDR;
output [0:6] HEX0;
output [0:6] HEX1;
output [0:6] HEX3;
output [0:6] HEX5;

reg [4:0] tempSum;
reg [3:0] sum;
reg [3:0] z0;
reg c1;

seven_segment_decoder s1(.digit(SW[3:0]), .seg(HEX3));
seven_segment_decoder s2(.digit(SW[7:4]), .seg(HEX5));
seven_segment_decoder s3(.digit(sum),.seg(HEX0));
seven_segment_decoder s4(.digit({3'b000, c1}), .seg(HEX1));
always @(*)begin
  tempSum = SW[3:0]+SW[7:4]+SW[8];
  if(tempSum>9) begin
    z0= 10;
    c1=1;
  end
  else begin
    z0=0;
    c1=0;
  end
  sum= tempSum-z0;
        


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