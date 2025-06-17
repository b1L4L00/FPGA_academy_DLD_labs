module lab1(SW, LEDR,KEY, HEX0,HEX1, HEX2, HEX3);
input [9:0] SW;
input [3:0] KEY;
output reg [9:0] LEDR;
output [6:0] HEX0, HEX1, HEX2, HEX3;
wire enableA = SW[8];
wire enableB = SW[9];
reg[7:0] A,B;
wire[15:0] product;


adder_tree_multiplier m1(.A(A),.B(B), .P(product));
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

module adder_tree_multiplier(

    input [7:0] A,
    input [7:0] B,
    output [15:0] P
);


    // Partial products
    wire [7:0] pp0 = B[0] ? A : 8'b0;
    wire [7:0] pp1 = B[1] ? A : 8'b0;
    wire [7:0] pp2 = B[2] ? A : 8'b0;
    wire [7:0] pp3 = B[3] ? A : 8'b0;
    wire [7:0] pp4 = B[4] ? A : 8'b0;
    wire [7:0] pp5 = B[5] ? A : 8'b0;
    wire [7:0] pp6 = B[6] ? A : 8'b0;
    wire [7:0] pp7 = B[7] ? A : 8'b0;
    
    // Properly shifted partial products
    wire [15:0] spp0 = {8'b0, pp0};
    wire [15:0] spp1 = {7'b0, pp1, 1'b0};
    wire [15:0] spp2 = {6'b0, pp2, 2'b0};
    wire [15:0] spp3 = {5'b0, pp3, 3'b0};
    wire [15:0] spp4 = {4'b0, pp4, 4'b0};
    wire [15:0] spp5 = {3'b0, pp5, 5'b0};
    wire [15:0] spp6 = {2'b0, pp6, 6'b0};
    wire [15:0] spp7 = {1'b0, pp7, 7'b0};
    
    // First level of adder tree
    wire [15:0] sum0 = spp0 + spp1;
    wire [15:0] sum1 = spp2 + spp3;
    wire [15:0] sum2 = spp4 + spp5;
    wire [15:0] sum3 = spp6 + spp7;
    
    // Second level of adder tree
    wire [15:0] sum4 = sum0 + sum1;
    wire [15:0] sum5 = sum2 + sum3;
    
    // Final sum
     assign P = sum4 + sum5;
    

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