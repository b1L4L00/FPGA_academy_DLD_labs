module part5(SW,HEX0 , HEX1, HEX2,HEX3);
input [9:0] SW;
output reg[0:6] HEX0;
output reg[0:6] HEX1;
output reg[0:6] HEX2;
output reg[0:6] HEX3;
//wire [1:0] decoderInput;
always @(*) begin
    case (SW[9:8])
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