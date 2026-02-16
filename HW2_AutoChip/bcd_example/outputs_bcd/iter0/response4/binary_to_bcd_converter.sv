module binary_to_bcd_converter (
    input  [4:0] binary_input,
    output reg [7:0] bcd_output
);
    
    always @* begin
        // Initialize the BCD output to zero
        bcd_output = 8'b00000000;

        // Convert binary input to BCD
        case (binary_input)
            5'd0:  bcd_output = 8'h00;
            5'd1:  bcd_output = 8'h01;
            5'd2:  bcd_output = 8'h02;
            5'd3:  bcd_output = 8'h03;
            5'd4:  bcd_output = 8'h04;
            5'd5:  bcd_output = 8'h05;
            5'd6:  bcd_output = 8'h06;
            5'd7:  bcd_output = 8'h07;
            5'd8:  bcd_output = 8'h08;
            5'd9:  bcd_output = 8'h09;
            5'd10: bcd_output = 8'h0A;
            5'd11: bcd_output = 8'h0B;
            5'd12: bcd_output = 8'h0C;
            5'd13: bcd_output = 8'h0D;
            5'd14: bcd_output = 8'h0E;
            5'd15: bcd_output = 8'h0F;
            5'd16: bcd_output = 8'h10;
            5'd17: bcd_output = 8'h11;
            5'd18: bcd_output = 8'h12;
            5'd19: bcd_output = 8'h13;
            5'd20: bcd_output = 8'h14;
            5'd21: bcd_output = 8'h15;
            5'd22: bcd_output = 8'h16;
            5'd23: bcd_output = 8'h17;
            5'd24: bcd_output = 8'h18;
            5'd25: bcd_output = 8'h19;
            5'd26: bcd_output = 8'h1A;
            5'd27: bcd_output = 8'h1B;
            5'd28: bcd_output = 8'h1C;
            5'd29: bcd_output = 8'h1D;
            5'd30: bcd_output = 8'h1E;
            5'd31: bcd_output = 8'h1F;
            default: bcd_output = 8'h00; // In case of invalid input
        endcase
    end
endmodule
