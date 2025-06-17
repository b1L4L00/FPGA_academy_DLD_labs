module lab1(clk,D,Q);
input clk,D;
output [2:0]Q;
SRLatch d1(.clk(clk), .D(D), .Q(Q[2])) ;
ffP f1(clk,D,Q[1]);
ffN f2(clk,D,Q[0]);

endmodule

module SRLatch(clk, D, Q);
input clk,D;
output reg Q;

always @(D,clk)begin
  if(clk)
  Q=D;
end

endmodule

module ffP(clk,D,Q);
input clk,D;
output reg Q;
always @(posedge clk)begin
    Q<=D;
end

endmodule

module ffN(clk,D,Q);
input clk,D;
output reg Q;
always @(negedge clk)begin
    Q<=D;
end

endmodule