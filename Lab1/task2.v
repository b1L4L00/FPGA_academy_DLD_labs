module  part2(
    LEDR, SW
);
input [9:0]SW;
output [3:0]LEDR;


assign LEDR = SW[9] ? SW[7:4] : SW[3:0];

    
endmodule
