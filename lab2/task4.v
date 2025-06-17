module lab1(SW, LEDR, HEX0, HEX1, HEX3, HEX5);
input [9:0] SW;
output [9:0] LEDR;
output [0:6] HEX0;
output [0:6] HEX1;
output [0:6] HEX3;
output [0:6] HEX5;
wire [4:0] tempSum;
wire cmp[1:0];

seven_segment_decoder s1(.digit(SW[3:0]), .seg(HEX3));
seven_segment_decoder s2(.digit(SW[7:4]), .seg(HEX5));
comp4Bit c1(.value(SW[3:0]), .valid(cmp[0]));
comp4Bit c2(.value(SW[7:4]), .valid(cmp[1]));
assign LEDR[9]= cmp[0]|cmp[1];
fourBitAdder A1(.a(SW[3:0]), .b(SW[7:4]), .cin(SW[8]), .sum(tempSum[3:0]), .cout(tempSum[4]));
assign LEDR[4:0] = tempSum;
decSum(.value(tempSum),.seg0(HEX0), .seg1(HEX1));


endmodule

module comp4Bit(value, valid);
input[3:0] value;
output reg valid;
always @(*) begin
if (value > 4'b1001) begin
    valid = 1'b1;
end
else begin 
    valid= 1'b0;
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


module fourBitAdder(a,b,cin, sum,cout);
input [3:0] a;
input [3:0] b;
input cin;
output [3:0] sum;
output cout;
wire [2:0] carry;
full_adder fa0(.a(a[0]), .b(b[0]), .cin(cin),      .sum(sum[0]), .cout(carry[0]));
full_adder fa1(.a(a[1]), .b(b[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
full_adder fa2(.a(a[2]), .b(b[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
full_adder fa3(.a(a[3]), .b(b[3]), .cin(carry[2]), .sum(sum[3]), .cout(cout));

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


module decSum(value, seg0, seg1);
input[4:0]value;
output  [0:6]seg0;
output reg [0:6]seg1;
reg [3:0] val1;
wire z;

comp4Bit c1(.value(value[3:0]), .valid(z));

seven_segment_decoder s1(.digit(val1), .seg(seg0));
always @(*) begin // this here is very specific code for only two bit BCD and is not valid for general case 
 if(!value[4])begin
  if(z==1'b0) begin
    val1 = value[3:0];
	seg1= 7'b0000001;
  end else begin
    val1= value[3:0] - 4'b1010;
       seg1= 7'b1001111;	
  end
 end
    else begin // as in combinational block assignment is one after the other so
       seg1= 7'b1001111;	
        val1= value[3:0] + 4'b0110;

    end

end

endmodule