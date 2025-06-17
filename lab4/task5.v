module lab1(HEX0 , HEX1, HEX2,HEX3,HEX4,HEX5, KEY, CLOCK_50);

input [0:0] KEY;
input CLOCK_50;
output reg[0:6] HEX0;
output reg[0:6] HEX1;
output reg[0:6] HEX2;
output reg[0:6] HEX3;
output reg[0:6] HEX4;
output reg[0:6] HEX5;
//wire [1:0] decoderInput;
reg [2:0] value;
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
            if(value==5)begin
                value<=0;
            end
            else  begin
                value <= value+1;
            end
            
        end
end

always @(*) begin
    case (value)
        3'b000: begin
          HEX0 = 7'b0000001; // 0
          HEX1 = 7'b1001111; // 1
          HEX2=  7'b0110000; // E
          HEX3 = 7'b1000010; // d
          HEX4 = 7'b1111111; //NULL
          HEX5 = 7'b1111111; //NULL
        end
       
        3'b001: begin
          HEX1 = 7'b0000001; // 0
          HEX2 = 7'b1001111; // 1
          HEX3=  7'b0110000; // E
          HEX4 = 7'b1000010; // d
          HEX5 = 7'b1111111; //NULL
          HEX0 = 7'b1111111; //NULL
        end

        3'b010: begin
          HEX2 = 7'b0000001; // 0
          HEX3 = 7'b1001111; // 1
          HEX4=  7'b0110000; // E
          HEX5 = 7'b1000010; // d
          HEX0 = 7'b1111111; //NULL
          HEX1 = 7'b1111111; //NULL
        end
        3'b011: begin
          HEX3 = 7'b0000001; // 0
          HEX4 = 7'b1001111; // 1
          HEX5=  7'b0110000; // E
          HEX0 = 7'b1000010; // d
          HEX1 = 7'b1111111; //NULL
          HEX2 = 7'b1111111; //NULL
        end
        3'b100: begin
          HEX4 = 7'b0000001; // 0
          HEX5 = 7'b1001111; // 1
          HEX0=  7'b0110000; // E
          HEX1 = 7'b1000010; // d
          HEX2 = 7'b1111111; //NULL
          HEX3 = 7'b1111111; //NULL
        end
        3'b101: begin
          HEX5 = 7'b0000001; // 0
          HEX0 = 7'b1001111; // 1
          HEX1=  7'b0110000; // E
          HEX2 = 7'b1000010; // d
          HEX3 = 7'b1111111; //NULL
          HEX4 = 7'b1111111; //NULL
        end


        default: begin
          HEX3 = 7'b1111111; // NULL
          HEX2 = 7'b1111111; // NULL
          HEX1 = 7'b1111111; // NULL
          HEX0 = 7'b1111111; // NULL
          HEX4 = 7'b1111111; // NULL
          HEX5 = 7'b1111111; // NULL
          
        end
    endcase;
end



endmodule