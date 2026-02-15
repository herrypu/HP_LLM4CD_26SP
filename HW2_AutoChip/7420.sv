// Module: top_module (7420 Dual 4-input NAND Gate)
// Description: Implementation of a classic TTL 7420 chip containing two independent 4-input NAND gates.

module top_module (
    // Gate 1 inputs and output
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,

    // Gate 2 inputs and output
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);

    // Using continuous assignment for combinational NAND logic
    // Logic: Y = ~(A & B & C & D)
    assign p1y = ~(p1a & p1b & p1c & p1d);
    assign p2y = ~(p2a & p2b & p2c & p2d);

endmodule