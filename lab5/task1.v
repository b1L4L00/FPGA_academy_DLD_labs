module lab1(LEDR,KEY);
output [9:0] LEDR;
input [3:0] KEY;
reg [7:0] count;
reg rollOver;
assign LEDR[7:0] = count;
assign LEDR[8] = rollOver;

always @(posedge KEY[1] or negedge KEY[0]) begin    
if(!KEY[0])begin
    count <= 0;
    rollOver <=0;
end
else begin 
    if(count ==20-1)begin
        count<=0;
        rollOver <=1;
    end
    else begin
        count<=count +1;
        rollOver <=0;
    end
    
end
end

endmodule