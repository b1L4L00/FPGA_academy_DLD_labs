module mydLatch(clk,D,Q);
input clk, D;
output Q;
wire S_g,R_g,Qa,Qb /* synthesis keep */ ;

assign S_g= ~(D&clk);
assign R_g= ~(~D&clk);

assign Qa= ~(S_g&Qb);
assign Qb= ~(R_g&Qa);

assign Q= Qa;
endmodule

module lab1(clk,D,Q);
input clk,D;
output Q;
wire Q1;
wire clk1;
assign clk1 = ~clk;
mydLatch d1(clk1,D,Q1);
mydLatch d2(clk,Q1,Q);
endmodule