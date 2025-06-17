
module lab1(
    input [7:0] SW,           
    input [1:0]KEY0,                          
    output [6:0] HEX0, HEX1,
    output [6:0] HEX2, HEX3,
    output [6:0] HEX4, HEX5,  
    output [9:0] LEDR         
);

    reg [7:0] A, B;
    reg [1:0] state; // 0: load A, 1: load B, 2+: hold
    wire [8:0] SUM;  // 9-bit to hold sum + carry

    // Handle reset and storing A and B
    always @(posedge KEY[1] or negedge KEY[0]) begin
        if (!KEY[0]) begin
            A <= 8'd0;
            B <= 8'd0;
            state <= 2'd0;
        end else begin
            case (state)
                2'd0: begin
                    A <= SW;
                    state <= 2'd1;
                end
                2'd1: begin
                    B <= SW;
                    state <= 2'd2;
                end
                default: ; // Hold values
            endcase
        end
    end

    assign SUM = A + B;

    
    assign LEDR[0] = SUM[8];

    
    hex7seg h0 (.in(B[3:0]),  .out(HEX0));
    hex7seg h1 (.in(B[7:4]),  .out(HEX1));

    hex7seg h2 (.in(A[3:0]),  .out(HEX2));
    hex7seg h3 (.in(A[7:4]),  .out(HEX3));

    hex7seg h4 (.in(SUM[3:0]),  .out(HEX4));
    hex7seg h5 (.in(SUM[7:4]),  .out(HEX5));

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
