module mux2to1(input wire in1, input wire in2, input wire select, output wire out);
  assign out = select ? in2 : in1;
endmodule
module mux4to1(input [1:0] sel, input [3:0] in, output reg out);
  wire y0, y1, y;

  mux2to1 m0(.in1(in[0]), .in2(in[1]), .select(sel[0]), .out(y0));
  mux2to1 m1(.in1(in[2]), .in2(in[3]), .select(sel[0]), .out(y1));
  mux2to1 m2(.in1(y0), .in2(y1), .select(sel[1]), .out(y));

  always @* begin
    out = y;
  end
endmodule
