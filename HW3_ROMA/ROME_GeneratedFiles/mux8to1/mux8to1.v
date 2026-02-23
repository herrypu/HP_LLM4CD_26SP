module mux2to1(input wire in1, input wire in2, input wire select, output wire out);
  assign out = select ? in2 : in1;
endmodule
module mux4to1(input wire [1:0] sel, input wire [3:0] in, output reg out);
  wire w0, w1, w2;

  mux2to1 u0 (.in1(in[0]), .in2(in[1]), .select(sel[0]), .out(w0));
  mux2to1 u1 (.in1(in[2]), .in2(in[3]), .select(sel[0]), .out(w1));
  mux2to1 u2 (.in1(w0),    .in2(w1),    .select(sel[1]), .out(w2));

  always @* begin
    out = w2;
  end
endmodule
module mux8to1(input wire [2:0] sel, input wire [7:0] in, output wire out);
  wire w_low, w_high, w_out;

  mux4to1 u_low  (.sel(sel[1:0]), .in(in[3:0]), .out(w_low));
  mux4to1 u_high (.sel(sel[1:0]), .in(in[7:4]), .out(w_high));
  mux2to1 u_top  (.in1(w_low), .in2(w_high), .select(sel[2]), .out(w_out));

  assign out = w_out;
endmodule
