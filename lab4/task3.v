module lab1(CLOCK_50,KEY, HEX0);
input CLOCK_50;
input [0:0] KEY;
input [6:0] HEX0;
reg [3:0] value;
reg [25:0] counter0;
reg enable;

always @(posedge CLOCK_50 or negedge KEY[0])begin
    if(!KEY[0])begin
        counter0 <= 0;
        enable <= 0;
    end
    else begin
        if(counter0==50000000)begin
            counter0<=0;
            enable <=1;
        end
        else begin
            counter0 <= counter0+1;
            enable <=0;
        end
    end
end
always @(posedge CLOCK_50 or negedge KEY[0]) begin
        if(!KEY[0])begin
        value <= 0;
    end
        else if(enable) begin
            if(value==9)begin
                value<=0;
            end
            else  begin
                value <= value+1;
            end
            
        end
end
 hex7seg display (.in(value), .out(HEX0));
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
            default: out = 7'b1111111;
        endcase
    end
endmodule
