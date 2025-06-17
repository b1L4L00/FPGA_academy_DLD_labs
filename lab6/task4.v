module lab1(SW, LEDR,KEY, HEX0,HEX1, HEX2, HEX3);
input [9:0] SW;
input [3:0] KEY;
output reg [9:0] LEDR;
output [6:0] HEX0, HEX1, HEX2, HEX3;
wire enableA = SW[8];
wire enableB = SW[9];
reg[7:0] A,B;
wire[15:0] product;


multiplier m1(.A(A),.B(B), .product(product));
always @(*) begin 
        if(enableA & !enableB)begin
            LEDR[7:0] = A;
        end else if (enableB & !enableA)begin
            LEDR[7:0] = B;
        end else begin
            LEDR[7:0] = 8'b00000000;
        end
end



always @(posedge KEY[1] or negedge KEY[0])begin
    if(!KEY[0])begin
      
        A<=0;
        B<=0;
    end else begin
        if(enableA) begin A<=SW[7:0] ;end
        if(enableB) begin B<=SW[7:0] ;end
   
    end
    
end
hex7seg h1(.in(product[3:0]),.out(HEX0));
hex7seg h2(.in(product[7:4]),.out(HEX1));
hex7seg h3(.in(product[11:8]),.out(HEX2));
hex7seg h4(.in(product[15:11]),.out(HEX3));
endmodule

module multiplier(A,B,product);
    input [7:0] A,B;
    output [15:0]  product;

    // variables for module
    wire [7:0] firstSum, secondSum, thirdSum, fourthSum, fifthSum,sixthSum, seventhSum;
    wire [6:0] carry;

    assign {carry[0],firstSum}= (({8{B[0]}}&A)>>1)+({8{B[1]}}&A);
    assign {carry[1],secondSum}= {carry[0],firstSum[7:1]}+({8{B[2]}}&A);
    assign {carry[2],thirdSum}= {carry[1],secondSum[7:1]}+({8{B[3]}}&A);
    assign {carry[3],fourthSum}= {carry[2],thirdSum[7:1]}+({8{B[4]}}&A);
    assign {carry[4],fifthSum}= {carry[3],fourthSum[7:1]}+({8{B[5]}}&A);
    assign {carry[5],sixthSum}= {carry[4], fifthSum[7:1]}+({8{B[6]}}&A);
    assign {carry[6],seventhSum}= {carry[5],sixthSum[7:1]}+({8{B[7]}}&A);
   

    // assigning products
assign product = {carry[6], seventhSum, sixthSum[0], fifthSum[0], fourthSum[0], thirdSum[0], secondSum[0], firstSum[0], (A[0] & B[0])};

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