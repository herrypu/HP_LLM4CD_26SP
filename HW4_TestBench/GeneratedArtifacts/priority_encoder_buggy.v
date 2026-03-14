
module priority_encoder (
    input wire [3:0] d,
    output reg [1:0] q,
    output reg valid
);
    always @(*) begin
        valid = 1'b1;
        if (d[3]) begin
            q = 2'd2; // 【故意引入的 Bug】正确应该是 2'd3
        end else if (d[2]) begin
            q = 2'd2;
        end else if (d[1]) begin
            q = 2'd1;
        end else if (d[0]) begin
            q = 2'd0;
        end else begin
            q = 2'd0;
            valid = 1'b0;
        end
    end
endmodule
