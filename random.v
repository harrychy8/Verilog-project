module random(input clk, output reg[7:0] y);

	reg[3:0] count = 4'b0;
	always@ (posedge clk)
	begin
		if (count == 4'b1111) count = 4'b0;
		else count = count + 1'b1;
		
		if (count == 4'b0000) y = 8'd33;
		else if (count == 4'b0001) y = 8'd44;
		else if (count == 4'b0010) y = 8'd20;
		else if (count == 4'b0011) y = 8'd25;
		else if (count == 4'b0101) y = 8'd18;
		else if (count == 4'b0110) y = 8'd29;
		else if (count == 4'b0111) y = 8'd18;
		else if (count == 4'b1000) y = 8'd36;
		else if (count == 4'b1001) y = 8'd01;
		else if (count == 4'b1010) y = 8'd31;
		else if (count == 4'b1011) y = 8'd13;
		else if (count == 4'b1100) y = 8'd22;
		else if (count == 4'b1101) y = 8'd05;
		else if (count == 4'b1101) y = 8'd42;
	end
	
endmodule
