//this module is for drawing the path way

module drawPath(
				input clk,
				input enable,
				input[7:0] c_x,
				input[6:0] c_y,
				input[7:0] e_x,
				input[6:0] e_y,
				
				output[7:0] x,
				output[6:0] y,
				output[2:0] color
				);

	wire next;
	drawCounter d0(clk,enable,next);
	
	reg flip = 1'b0;
	reg[7:0] draw_x = 8'b0;
	reg[6:0] draw_y = 7'b0;
	
	always@ (posedge next, negedge enable)
	begin
		if (!enable) //reset data
		begin
			flip = 1'b0;
			draw_x = 8'b0;
			draw_y = 7'b0;
		end
		
		else 
		begin
			if (draw_x == 8'b0)
			begin
			draw_x = c_x;
			draw_y = c_y;
			
			if (c_x == e_x || c_y == e_y) flip = 1'b1;
		
			end
			
			
			if (!flip)
			begin
				draw_x = draw_x + 1'b1;   //goes upward until reaches the end
				draw_y = draw_y - 1'b1;
				
				if(draw_x == e_x || draw_y == e_y) flip = 1'b1;
			
			end
			
			else 
			begin
				draw_x = draw_x + 1'b1;		//goes down
				draw_y = draw_y + 1'b1;
			end
		end
	end
	
	assign x = draw_x;
	assign y = draw_y;
	assign color = 3'b101;
	
endmodule


module drawCounter(input clk, input enable, output reg next);

reg[23:0] delay = 24'b0;
	
	always@ (posedge clk)
	begin
		if (enable)
		begin
			if (delay == 24'b101111101011110000100000) // enable every 0.25sec
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
