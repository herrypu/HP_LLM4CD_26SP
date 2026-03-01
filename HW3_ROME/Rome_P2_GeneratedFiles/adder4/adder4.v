module half_adder(
    input wire a,
    input wire b,
    output wire sum,
    output wire carry
);
  assign sum = a ^ b;
  assign carry = a & b;
endmodule
module full_adder(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);
  wire w1, w2, w3;
  half_adder HA1(a, b, w1, w2);
  half_adder HA2(w1, cin, sum, w3);
  assign cout = w2 | w3;
endmodule
module adder4(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
);
  wire c1, c2, c3;
  full_adder FA1(a[0], b[0], cin, sum[0], c1);
  full_adder FA2(a[1], b[1], c1, sum[1], c2);
  full_adder FA3(a[2], b[2], c2, sum[2], c3);
  full_adder FA4(a[3], b[3], c3, sum[3], cout);
endmodule
