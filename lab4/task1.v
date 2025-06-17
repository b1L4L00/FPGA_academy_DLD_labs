module lab1(SW,KEY,HEX0,HEX1);
input[9:0] SW;
input [3:0]KEY;
output [6:0] HEX0;
output[6:0] HEX1;
wire [7:0] value;
wire [6:0] toggle; //for second myTFF we use toggle[0]
hex7seg h1(.in(value[3:0]), .out(HEX0));
hex7seg h2(.in(value[7:4]), .out(HEX1));


myTFF t1(.clk(KEY[0]),.T(SW[1]), .Q(value[0]), .nreset(KEY[1]));
assign toggle[0]=SW[1]&value[0];

myTFF t2(.clk(KEY[0]),.T(toggle[0]), .Q(value[1]), .nreset(KEY[1]));
assign toggle[1]= toggle[0]&value[1];

myTFF t3(.clk(KEY[0]),.T(toggle[1]), .Q(value[2]), .nreset(KEY[1]));
assign toggle[2]= toggle[1]&value[2];

myTFF t4(.clk(KEY[0]),.T(toggle[2]), .Q(value[3]), .nreset(KEY[1]));
assign toggle[3]= toggle[2]&value[3];

myTFF t5(.clk(KEY[0]),.T(toggle[3]), .Q(value[4]), .nreset(KEY[1]));
assign toggle[4]= toggle[3]&value[4];

myTFF t6(.clk(KEY[0]),.T(toggle[4]), .Q(value[5]), .nreset(KEY[1]));
assign toggle[5]= toggle[4]&value[5];

myTFF t7(.clk(KEY[0]),.T(toggle[5]), .Q(value[6]), .nreset(KEY[1]));
assign toggle[6]= toggle[5]&value[6];

myTFF t8(.clk(KEY[0]),.T(toggle[6]), .Q(value[7]), .nreset(KEY[1]));

endmodule

module myTFF(clk, T, Q, nreset);
input clk, T, nreset;
output reg Q;
always @(posedge clk or negedge nreset) begin
    if(!nreset) begin
        Q<=1'b0;
    end
    else begin
        Q <= T^Q;
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
