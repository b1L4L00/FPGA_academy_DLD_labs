module lab1(
    SW, HEX0, HEX1
);
input [9:0] SW;
output [0:6] HEX0;
output [0:6] HEX1;

seven_segment_decoder(.digit(SW[0:3]), .seg(HEX0));
seven_segment_decoder(.digit(SW[4:7]), .seg(HEX1));
    
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
