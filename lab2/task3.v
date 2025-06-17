module lab1(SW, LEDR);
input [9:0] SW;
output [9:0] LEDR;
wire [2:0] carry;
full_adder fa0(.a(SW[0]), .b(SW[4]), .cin(SW[8]), .sum(LEDR[0]), .cout(carry[0]));
full_adder fa1(.a(SW[1]), .b(SW[5]), .cin(carry[0]), .sum(LEDR[1]), .cout(carry[1]));
full_adder fa2(.a(SW[2]), .b(SW[6]), .cin(carry[1]), .sum(LEDR[2]), .cout(carry[2]));
full_adder fa3(.a(SW[3]), .b(SW[7]), .cin(carry[2]), .sum(LEDR[3]), .cout(LEDR[4]));

endmodule

module full_adder (
    input  a,      // First input bit
    input  b,      // Second input bit
    input  cin,    // Carry-in
    output sum,    // Sum output
    output cout    // Carry-out
);

assign sum  = a ^ b ^ cin;          // XOR for sum
assign cout = (a & b) | (b & cin) | (a & cin);  // Majority function for carry

endmodule
