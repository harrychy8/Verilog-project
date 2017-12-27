//this module is for calculating the height that can be reached based on strength

module end_point(
			input enable,
			input[7:0] strength,
			input[7:0] c_x,
			input[6:0] c_y,
			
			output reg[7:0] e_x,
			output reg[6:0] e_y
			);
			
always @(*)
	begin
		if (!enable)
		begin
			e_x = 8'd0;
			e_y = 8'd0;
		end
		
		else 
		begin
			if (strength == 8'd0)//0
			begin
				e_x = c_x;
				e_y = c_y;
			end
			
			else if (strength == 8'd10)//1
			begin
				e_x = c_x + 8'd4;
				e_y = c_y - 7'd4;
			end
			
			else if (strength == 8'd20)//2
			begin
				e_x = c_x + 8'd8;
				e_y = c_y - 7'd8;
			end
			
			else if (strength == 8'd30)//3
			begin
				e_x = c_x + 8'd12;
				e_y = c_y - 7'd12;
			end
			
			else if (strength == 8'd40)//4
			begin
				e_x = c_x + 8'd16;
				e_y = c_y - 7'd16;
			end
			
			else if (strength == 8'd50)//5
			begin
				e_x = c_x + 8'd20;
				e_y = c_y - 7'd20;
			end
			
			else if (strength == 8'd60)//6
			begin
				e_x = c_x + 8'd24;
				e_y = c_y - 7'd24;
			end
			
			else if (strength == 8'd70)//7
			begin
				e_x = c_x + 8'd28;
				e_y = c_y - 7'd28;
			end
			
			else if (strength == 8'd80)//8
			begin
				e_x = c_x + 8'd32;
				e_y = c_y - 7'd32;
			end
			
			else if (strength == 8'd90)//9
			begin
				e_x = c_x + 8'd36;
				e_y = c_y - 7'd36;
			end
			
			else  //10
			begin
				e_x = c_x + 8'd40;
				e_y = c_y - 7'd40;
			end
		end
	end

endmodule
