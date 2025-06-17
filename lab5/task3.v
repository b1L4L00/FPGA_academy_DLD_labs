module lab1(CLOCK_50, KEY, HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,SW);
input CLOCK_50;
input [3:0] KEY;
input[9:0] SW;
output [0:6] HEX0, HEX1, HEX2, HEX3,HEX4, HEX5;
wire [3:0] tenthOfSecU, tenthOfSecT, secU, secT, minU, minT;
wire tick, rollOverTenthSecU, rollOverTenthSecT, rollOverSecU, rollOverSecT;
reg [3:0] unit,ten;
reg [6:0] valueBCD ;


//assigning values for timer
always @(posedge KEY[1]) begin
valueBCD <= (SW[7:4]*10)+SW[3:0];
    
end
reg stopped;
always @(posedge CLOCK_50 or negedge KEY[1]) begin
    if (!KEY[1])
        stopped <= 1'b0;
    else if (minutes == valueBCD)
        stopped <= 1'b1;
end

wire gatedTick = (KEY[0] && !stopped) ? tick : 1'b0;


tenthOfSec t1(.clk(CLOCK_50),.nreset(KEY[1]), .Tick(tick));

//instantiating the clock;
counter  c1(.nreset(KEY[1]),.value(tenthOfSecU),.tick(gatedTick),.limit(10), .rollOver(rollOverTenthSecU) );
counter c2(.nreset(KEY[1]),.value(tenthOfSecT),.tick(rollOverTenthSecU),.limit(6), .rollOver(rollOverTenthSecT) );
counter  c3(.nreset(KEY[1]),.value(secU),.tick(rollOverTenthSecT), .limit(10),.rollOver(rollOverSecU) );
counter c4(.nreset(KEY[1]),.value(secT),.tick(rollOverSecU), .limit(6),.rollOver(rollOverSecT) );
//counter  c5(.nreset(KEY[1]),.value(minU),.tick(rollOverSecT),.limit(value), .rollOver() );

reg [6:0] minutes;
always @(posedge rollOverSecT or negedge KEY[1] ) begin
    if (!KEY[1]) begin
        minutes <= 0;
    end else begin
        if(!(minutes == valueBCD))begin
        minutes = minutes+1;
        end
    end
end



//hex display
seven_segment_decoder h0(.digit(tenthOfSecU), .seg(HEX0));
seven_segment_decoder h1(.digit(tenthOfSecT), .seg(HEX1));
seven_segment_decoder h2(.digit(secU),        .seg(HEX2));
seven_segment_decoder h3(.digit(secT),        .seg(HEX3));
DisplayForMinutes d1(minutes, HEX4, HEX5);

endmodule



module counter (
    input nreset,
    input tick,
    input [3:0] limit,
    output reg [3:0] value,
    output reg rollOver
);
always @(posedge tick or negedge nreset ) begin
    if (!nreset) begin
        value <= 0;
        rollOver <= 0;
    end else begin
        if (value == limit - 1) begin
            value <= 0;
            rollOver <= 1;
        end else begin
            value <= value + 1;
            rollOver <= 0;
        end
    end
end
endmodule






module tenthOfSec(clk,nreset,Tick);
input clk;
input nreset;
reg [19:0] counter0;
output reg Tick;

always @(posedge clk or negedge nreset)begin
    if(!nreset)begin
        counter0 <= 0;
        Tick <= 0;
    end
    else begin
        if(counter0==500000)begin
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



module DisplayForMinutes(SW,HEX0,HEX1);
input [6:0] SW;
output [0:6] HEX0;
output [0:6] HEX1;

//reg [7:0] tempSum; // for any two n bit  numbers sum can be n+1 bits
reg [3:0] S0;
reg [2:0] S1;

seven_segment_decoder s1(.digit(S0), .seg(HEX0));
seven_segment_decoder s2(.digit({1'b0,S1}), .seg(HEX1));
always @(*)begin
// there are possibilities for total so using the logic as used in previous example
if(SW<10)begin
  S0= SW;
  S1= 0;
end
else if(SW>9 && SW<20)begin
  S0 = SW-10;
  S1=1;
end
else if(SW>19 && SW<30)begin
  S0 = SW-20;
  S1=2;
end
else if(SW>29 && SW<40)begin
  S0 = SW-30;
  S1=3;
end
else if(SW>39 && SW<50)begin
  S0 = SW-40;
  S1=4;
end
else if(SW>49 && SW<60)begin
  S0 = SW-50;
  S1=5;
end
else if(SW>59 && SW<70)begin
  S0 = SW-60;
  S1=6;
end
else if(SW>69 && SW<80)begin
  S0 = SW-70;
  S1=7;
end
else if(SW>79 && SW<90)begin
  S0 = SW-80;
  S1=8;
end
else if(SW>89 && SW<100)begin
  S0 = SW-90;
  S1=9;
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
