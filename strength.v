//this module is oen of the state which ask the player to input the strength

module getStrength(
			input enable, 
			input clk, 
			output[7:0] strength,
			output [7:0] x,
			output [6:0] y,
			output reg [2:0] color
			);
	
	wire next;
	counter c1(clk,enable,next);
	
	//initial value
	reg add = 1'b1;
	reg erase = 1'b0;
	reg[7:0] result = 8'b0;
	reg[7:0] x_start = 8'd45;
	reg[6:0] y_start = 7'd73;
	
	always@ (posedge clk)
	begin
			if(add) 
			begin
				if (result == 8'd0)//0
					color = 3'b110;
				else if (result == 8'd10)//1
					color = 3'b110;
				else if (result == 8'd20)//2
					color = 3'b110;
				else if (result == 8'd30)//3
					color = 3'b110;
				else if (result == 8'd40)//4
					color = 3'b101;
				else if (result == 8'd50)//5
					color = 3'b101;
				else if (result == 8'd60)//6
					color = 3'b101;
				else if (result == 8'd70)//7
					color = 3'b100;
				else if (result == 8'd80)//8
					color = 3'b100;
				else if (result == 8'd90)//9
					color = 3'b100;
			end
			
			else 
			begin
				if (result == 8'd90) color = 3'b111;
			end
		
	end
		
	always@ (posedge next, negedge enable)
	begin
		if (!enable)
		begin
			add = 1'b1;
			erase = 1'b0;
			x_start = 8'd45;
			y_start = 7'd73;
			result = 8'd0;
		end
		
		else
		begin
			if (add)
			begin 
				//enable drawing
				
				result = result + 8'd10; //add 10 strength

				if (result == 8'd100) //if reach 100 strength, change to minus
				begin
					add = ~add;
					erase = 1'b1;
				end
				
				else //if not 100 yet, change x position
				begin
					x_start = x_start + 8'd8;
				end
				
			end 
			
			else 
			begin 
				//enable drawing

				result = result - 8'd10; //minus 10 strength

				if (result == 8'd0) //if reach 0 degree
					begin 
						add = ~add;
						x_start = x_start - 8'd8;
					end
				
				else if (erase) erase = 1'b0;
				
				else 		//if not 0 yet, change x position
					begin
					x_start = x_start - 8'd8;
					end				
			end
		end
	end	

	assign strength = result;
	assign x = x_start;
	assign y = y_start;

endmodule 