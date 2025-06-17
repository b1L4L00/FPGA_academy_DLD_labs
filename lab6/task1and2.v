//for task 2 only change the line  
//wire [8:0] tempSum = A+sum; to mentioned below this treats SW[9] as the add_sub input
 
//wire [8:0] tempSum = SW[9] ? (sum - A) : (sum + A);
module lab1(SW, KEY, LEDR, HEX0,HEX1,HEX2,HEX3);
reg [7:0] A, sum;
reg Overflow, carry;
wire ovF = ((~(A[7]^sum[7]))&(tempSum[7]^tempSum[8]));
wire [8:0] tempSum = SW[9] ? (sum - A) : (sum + A);
output [6:0] HEX0, HEX1, HEX2, HEX3;
input [9:0] SW;
 input[3:0] KEY; 
 output[9:0] LEDR;

always @(posedge KEY[0] or negedge KEY[1]) begin
    if(!KEY[1])begin
        A <=0;
        sum <= 0;
    end else begin
        A<= SW[7:0];
        sum <=tempSum[7:0];
        carry <= tempSum[8];
        Overflow <= ovF;
    end
    
end

hex_decoder h0 (.nibble(sum[3:0]), .seg(HEX0));
hex_decoder h1 (.nibble(sum[7:4]), .seg(HEX1));
hex_decoder h2 (.nibble(A[3:0]),   .seg(HEX2));
hex_decoder h3 (.nibble(A[7:4]),   .seg(HEX3));

assign LEDR[7:0] = sum;
assign LEDR[8] = carry;
assign LEDR[9] = Overflow;
endmodule

module hex_decoder(input [3:0] nibble, output reg [6:0] seg);
    always @(*) begin
        case(nibble)
            4'h0: seg = 7'b100_0000;
            4'h1: seg = 7'b111_1001;
            4'h2: seg = 7'b010_0100;
            4'h3: seg = 7'b011_0000;
            4'h4: seg = 7'b001_1001;
            4'h5: seg = 7'b001_0010;
            4'h6: seg = 7'b000_0010;
            4'h7: seg = 7'b111_1000;
            4'h8: seg = 7'b000_0000;
            4'h9: seg = 7'b001_0000;
            4'hA: seg = 7'b000_1000;
            4'hB: seg = 7'b000_0011;
            4'hC: seg = 7'b100_0110;
            4'hD: seg = 7'b010_0001;
            4'hE: seg = 7'b000_0110;
            4'hF: seg = 7'b000_1110;
            default: seg = 7'b111_1111; // Blank
        endcase
    end
endmodule
