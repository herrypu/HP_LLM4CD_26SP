module half_adder(
    input wire a, 
    input wire b, 
    output wire sum, 
    output wire carry
);
assign sum = a ^ b;
assign carry = a & b;
endmodule
module full_adder(input wire a, input wire b, input wire cin, output wire sum, output wire cout);
wire w1, w2, w3;
half_adder HA1(a, b, w1, w2);
half_adder HA2(w1, cin, sum, w3);
assign cout = w2 | w3;
endmodule
