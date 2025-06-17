
module lab1(clk,D,Q);
input clk, D;
output Q;
wire S_g,R_g,Qa,Qb /* synthesis keep */ ;

assign S_g= ~(D&clk);
assign R_g= ~(~D&clk);

assign Qa= ~(S_g&Qb);
assign Qb= ~(R_g&Qa);

assign Q= Qa;
endmodule

// the pin assignment should be done seperately mapping clk, and D to SW1 and SW0 respectively