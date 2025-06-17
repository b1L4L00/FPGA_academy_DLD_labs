module lab1(CLOCK_50, KEY, HEX0,HEX1,HEX2);
input CLOCK_50;
input [3:0] KEY;
output [6:0] HEX0, HEX1, HEX2;

wire [3:0] one, ten, hundred;
wire tick,rollOverU, rollOverT;
hex7seg h1(.in(one),.out(HEX0));
hex7seg h2(.in(ten),.out(HEX1));
hex7seg h3(.in(hundred),.out(HEX2));

oneSec O1(.clk(CLOCK_50), .nreset(KEY[0]), .Tick(tick));
//for tens 
counter c1(KEY[0],one,tick,rollOverU);
counter c2(KEY[0],ten,rollOverU,rollOverT);
counter c3(.nreset(KEY[0]), .value(hundred), .tick(rollOverT), .rollOver());

endmodule

module counter #(parameter k=10 )(
    nreset, value, tick, rollOver
);

input nreset;
input tick;
output reg [3:0] value;
output reg rollOver;

always @(posedge tick or negedge nreset ) begin
    if(!nreset)begin
        value <= 0;
        rollOver <=0;
    end else begin
        if(value==k-1)begin
            value<=0;
            rollOver<=1;
        end else begin
            value<= value+1;
            rollOver <= 0;
        end
    end
end

endmodule

module oneSec(clk,nreset,Tick,);
input clk;
input nreset;
reg [25:0] counter0;
output reg Tick;

always @(posedge clk or negedge nreset)begin
    if(!nreset)begin
        counter0 <= 0;
        Tick <= 0;
    end
    else begin
        if(counter0==50000000)begin
            counter0<=0;
            Tick <=1;
        end
        else begin
            counter0 <= counter0+1;
            Tick <=0;
        end
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