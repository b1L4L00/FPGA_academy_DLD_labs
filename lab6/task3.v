module lab1(SW, HEX0,  HEX2,HEX4,HEX5);
input [9:0] SW;
output [6:0] HEX0,  HEX2, HEX4,HEX5;

wire [3:0] A= SW[3:0];
wire [3:0] b= SW[7:4];
wire product [7:0];
wire carryF[3:0];

hex7seg h1(.in(A), .out(HEX2));
hex7seg h2(.in(B), .out(HEX0));
hex7seg h3(.in(product[3:0]), .out(HEX4));
hex7seg h4(.in(product[7:4]), .out(HEX5));
// bit wise ands

assign product[0] = A[0] & B[0];
assign product[1] = firstSum[0];
assign product[2] = secondSum[0];
assign product[6:3] = thirdSum;
assign product[7] = carryT[3];

wire [3:0] firstSum;
assign {carryF[0],firstSum[0]} = (A[1]&B[0] + A[0]&B[1]);
assign {carryF[1],firstSum[1]} = (A[2]&B[0] + A[1]&B[1] + carryF[0]);
assign {carryF[2],firstSum[1]} = (A[3]&B[0] + A[2]&B[1] + carryF[1]);
assign {carryF[3],firstSum[1]} = (            A[3]&B[1] + carryF[2]);

wire  [3:0] carryS;
wire[3:0]   secondSum
assign {carryS[0],secondSum[0]} = (firstSum[1]+A[0]&B[2])
assign {carryS[1],secondSum[1]} = (firstSum[2] + A[1]&B[2] + carryS[0]);
assign {carryS[2],secondSum[1]} = (firstSum[3] + A[2]&B[2] + carryS[1]);
assign {carryS[3],secondSum[1]} = ( carryF[3]   +  A[3]&B[2] + carryS[2]);


wire  [3:0] carryT;
wire[3:0]   thirdSum
assign {carryT[0],thirdSum[0]} = (secondSum[1]+A[0]&B[3])
assign {carryT[1],thirdSum[1]} = (secondSum[2] + A[1]&B[3] + carryT[0]);
assign {carryT[2],thirdSum[1]} = (secondSum[3] + A[2]&B[3] + carryT[1]);
assign {carryT[3],thirdSum[1]} = ( carryS[3]   +  A[3]&B[3] + carryT[2]);



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

