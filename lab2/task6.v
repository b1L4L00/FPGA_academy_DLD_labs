module lab1(SW,HEX0,HEX1);
input [5:0] SW;
output [0:6] HEX0;
output [0:6] HEX1;

//reg [7:0] tempSum; // for any two n bit  numbers sum can be n+1 bits
reg [3:0] S0;
reg [2:0] S1;

seven_segment_decoder s1(.digit(S0), .seg(HEX0));
seven_segment_decoder s2(.digit({1'b0,S1}), .seg(HEX1));
always @(*)begin
// there are possibilities for total so using the logic as used in previous example
if(SW<10)begin
  S0= SW;
  S1= 0;
end
else if(SW>9 && SW<20)begin
  S0 = SW-10;
  S1=1;
end
else if(SW>19 && SW<30)begin
  S0 = SW-20;
  S1=2;
end
else if(SW>29 && SW<40)begin
  S0 = SW-30;
  S1=3;
end
else if(SW>39 && SW<50)begin
  S0 = SW-40;
  S1=4;
end
else if(SW>49 && SW<60)begin
  S0 = SW-50;
  S1=5;
end
else if(SW>59 && SW<70)begin
  S0 = SW-60;
  S1=6;
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
