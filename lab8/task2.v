module lab1(SW, KEY, HEX0,HEX4,HEX5,HEX2);
input[9:0] SW;
input [3:0] KEY;
output[6:0] HEX0, HEX4, HEX5, HEX2;

wire [3:0] data;
ram32x4(.address(SW[8:4]), .clock(KEY[0]), .data(SW[3:0]), .wren(SW[9]), .q(data));
//you create this module via IP cataloging
hex7seg h1(.in(data), .out(HEX0));
hex7seg h2(.in(SW[3:0]), .out(HEX2));
hex7seg h3(.in(SW[7:4]), .out(HEX4));
hex7seg h4(.in({3'b000,SW[8]}), .out(HEX5));



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