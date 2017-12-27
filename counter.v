//this module is a counter for both angle and strength module

module counter(input clk, input enable, output reg next);
	
	reg[23:0] delay = 24'b0;
	
	always@ (posedge clk)
	begin
		if (enable)
		begin
			if (delay == 24'b101111101011110000100000) // enable every 0.05sec
			begin 
				delay = 24'b0;
				next = 1'b1;
			end
			
			else 
			begin 
				delay = delay + 3'd5;
				next = 1'b0;
			end
		end
		
		else
		begin 
			delay = 24'b0;
			next = 1'b0;
		end
	end
endmodule


