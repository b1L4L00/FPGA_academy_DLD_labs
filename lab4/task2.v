module lab1(KEY, HEX0, HEX1,HEX2,HEX3);
input[3:0] KEY;
output [6:0] HEX0,HEX1, HEX2, HEX3;
reg [15:0] value;

hex7seg h1(.in(value[3:0]), .out(HEX0));
hex7seg h2(.in(value[7:4]), .out(HEX1));
hex7seg h3(.in(value[11:8]), .out(HEX2));
hex7seg h4(.in(value[15:12]), .out(HEX3));

always @(posedge KEY[0]or negedge KEY[1]) begin
    if(!KEY[1])begin
        value<= 0;
    end
    else begin
        value<= value+1;
    end
end


endmodule

module hex7seg(input [3:0] in, output reg [6:0] out);
    always @(*) begin
        case (in)
            4'h0: out = 7'b1000000;
            4'h1: out = 7'b1111001;
            4'h2: out = 7'b0100100;
            4'h3: out = 7'b0110000;
            4'h4: out = 7'b0011001;
            4'h5: out = 7'b0010010;
            4'h6: out = 7'b0000010;
            4'h7: out = 7'b1111000;
            4'h8: out = 7'b0000000;
            4'h9: out = 7'b0011000;
            4'hA: out = 7'b0001000;
            4'hB: out = 7'b0000011;
            4'hC: out = 7'b1000110;
            4'hD: out = 7'b0100001;
            4'hE: out = 7'b0000110;
            4'hF: out = 7'b0001110;

            default: out = 7'b1111111;
        endcase
    end
endmodule
