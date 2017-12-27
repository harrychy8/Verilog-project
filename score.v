//this module is to calculate current based on input angle and strength

module score(input reset, input[7:0] angle, strength, output[7:0] score);
	
	reg[7:0] result = 8'b0;
	
	always@ (posedge reset)
	begin
		if (angle == 8'd0 || angle == 8'd90)
		begin 
			result = 8'b0;
		end
		
		else if (angle == 8'd5 || angle == 8'd85)
		begin 
			result = strength / 8;
		end
		
		else if (angle == 8'd10 || angle == 8'd80)
		begin 
			result = strength / 7;
		end
		
		else if (angle == 8'd15 || angle == 8'd75)
		begin 
			result = strength / 6;
		end
		
		else if (angle == 8'd20 || angle == 8'd70)
		begin 
			result = strength / 5;
		end
		
		else if (angle == 8'd25 || angle == 8'd65)
		begin 
			result = strength / 4;
		end
		
		else if (angle == 8'd30 || angle == 8'd60)
		begin 
			result = strength / 3;
		end
		
		else if (angle == 8'd35 || angle == 8'd55)
		begin 
			result = strength / 2;
		end
		
		else if (angle == 8'd40 || angle == 8'd50)
		begin 
			result = strength;
		end
		
		else 
		begin 
			result = strength * 2;
		end
	end
	
	assign score = result;
	
endmodule

		