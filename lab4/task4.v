module part5(HEX0 , HEX1, HEX2,HEX3, CLOCK_50, KEY);

input CLOCK_50;
input [0:0] KEY;
output reg[0:6] HEX0;
output reg[0:6] HEX1;
output reg[0:6] HEX2;
output reg[0:6] HEX3;

reg [1:0] value;
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
            if(value==3)begin
                value<=0;
            end
            else  begin
                value <= value+1;
            end
            
        end
end

//wire [1:0] decoderInput;

always @(*) begin
    case (value)
        2'b00: begin
          HEX0 = 7'b0000001; // 0
          HEX1 = 7'b1001111; // 1
          HEX2=  7'b0110000; // E
          HEX3 = 7'b1000010; // d
        end
       
        2'b01: begin
          HEX1 = 7'b0000001;
          HEX2 = 7'b1001111;
          HEX3=  7'b0110000;
          HEX0 = 7'b1000010;
        end
        2'b10:begin
          HEX2 = 7'b0000001; // 0
          HEX3 = 7'b1001111; // 1
          HEX0=  7'b0110000; // E
          HEX1 = 7'b1000010; // d
        end
       
        2'b11: begin
          HEX3 = 7'b0000001; // 0
          HEX0 = 7'b1001111; // 1
          HEX1=  7'b0110000; // E
          HEX2 = 7'b1000010; // d
        end
       
        default: begin
          HEX3 = 7'b1111111; // 0
          HEX2 = 7'b1111111; // 0
          HEX1 = 7'b1111111; // 0
          HEX0 = 7'b1111111; // 0
          
        end
    endcase;
end


// improvements: I can use local params to define the binary code for each letter
endmodule