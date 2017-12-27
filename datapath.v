//the module for datapath
//recive data from the control

module datapath(
			input clk,
			input resetn,

			input datapath_reset,
			input datapath_start,
			input datapath_target,
			input datapath_load_angle,
			input datapath_wait,
			input datapath_load_strength,
			input datapath_draw,
			input datapath_win,
			input datapath_lose,

			output reg[6:0] counter_square,
			output reg[7:0] display_angle,display_strength,display_score,
			output reg [7:0] x,
			output reg [6:0] y,
			output reg [2:0] color,
			output reg writeEn,
			output reg win,
			output reg lose
			);
	
	
	reg[7:0] data_x;
	reg[6:0] data_y;
	wire[7:0] random_x;
	reg draw_enable;
	reg angle_enable;
	reg strength_enable;
	
	wire[7:0] angle, strength;
	
	wire[7:0] str_x, s_x;
	wire[6:0] str_y, s_y;
	wire[2:0] str_color, s_c;
	
	wire[7:0] ang_x;
	wire[6:0] ang_y;
	wire[2:0] ang_color;
	
	wire[7:0] end_x;
	wire[6:0] end_y;
	
	wire[7:0] draw_x;
	wire[6:0] draw_y;
	wire[2:0] draw_color;
	
	//load front page
	wire[2:0] front_color;
	load_frontPic l0(clk,data_x,data_y,front_color);
	
	//load starting game page
	wire[2:0] start_color;
	load_startPic l1(clk,data_x,data_y,start_color);
	
	//load win page
	wire[2:0] win_color;
	load_winPic l2(clk,data_x,data_y,win_color);
	
	//load lose page
	wire[2:0] lose_color;
	load_losePic l3(clk,data_x,data_y,lose_color);
	
	//load target page
	wire[2:0] target_color;
	load_targetPic l4(clk,counter_square + 1'b1,target_color);
	
	//random
	random r0(datapath_start,random_x);
	
	//getAngle module 
	getAngle g0(
				.enable(angle_enable),
				.clk(clk),
				.angle(angle),
				.x(ang_x),
				.y(ang_y),
				.color(ang_color)
				);
				
	//getStrength module
	getStrength g1(
				.enable(strength_enable),
				.clk(clk),
				.strength(strength),
				.x(str_x),
				.y(str_y),
				.color(str_color)
				);
	
	strength_wait w0(
				.enable(strength_enable),
				.x_in(str_x),
				.y_in(str_y),
				.color_in(str_color),
				.x_out(s_x),
				.y_out(s_y),
				.color_out(s_c)
				);
	
	//get where the endpoints should be 
	end_point e0(
				.enable(draw_enable),
				.strength(display_strength),
				.c_x(data_x),
				.c_y(data_y),
				.e_x(end_x),
				.e_y(end_y)
				);
				
	//the module to give the path
	drawPath d2(
				.clk(clk),
				.enable(draw_enable),
				.c_x(data_x),
				.c_y(data_y),
				.e_x(end_x),
				.e_y(end_y),
				.x(draw_x),
				.y(draw_y),
				.color(draw_color)
				);

	always@ (posedge clk)
	begin
		if (!resetn) //initalize every data such as angle, strength, score
		begin
			display_angle = 8'b0;
			display_strength = 8'b0;
			display_score = 8'b0;
			angle_enable = 1'b0;
			strength_enable = 1'b0;
			draw_enable = 1'b0;
			counter_square = 7'b0;
			data_x <= 8'b0;
			data_y <= 7'b0;
			writeEn = 1'b0;
			win = 1'b0;
			lose = 1'b0;
		end
		
		else 
		begin
			if (datapath_reset)  //initalize every data such as angle, strength, score
			begin
				display_angle = 8'b0;
				display_strength = 8'b0;
				display_score = 8'b0;
				angle_enable = 1'b0;
				strength_enable = 1'b0;
				draw_enable = 1'b0;
				counter_square = 7'b0;
				data_x <= 8'b0;
				data_y <= 7'b0;
				writeEn = 1'b1;
				win = 1'b0;
				lose = 1'b0;
				
				//draw the background 
				//when finish
				if (data_x == 8'd159 && data_y == 7'd119)
				begin
					writeEn = 1'b0;
				end
				
				//when reach end
				else if (data_x == 8'd159) 
				begin
					data_x <= 1'b0;
					data_y <= data_y + 1'b1;
					x <= data_x;
					y <= data_y;
					color <= front_color;
				end
				
				//regular cases
				else
				begin
					data_x <= data_x + 1'b1;
					data_y <= data_y;
					x <= data_x;
					y <= data_y;
					color <= front_color;
				end
				
				
			end
			
			if (datapath_start)
			begin
				//state may change right from score state
				//need to reset data as well
				display_angle = 8'b0;
				display_strength = 8'b0;
				angle_enable = 1'b0;
				strength_enable = 1'b0;
				draw_enable = 1'b0;
				counter_square = 7'b0;
				data_x <= 8'b0;
				data_y <= 7'b0;
				writeEn = 1'b1;
				win = 1'b0;
				lose = 1'b0;
				
				//draw the background 
				//when finish
				if (data_x == 8'd159 && data_y == 7'd119)
				begin

					writeEn = 1'b0;
				end
				
				//when reach end
				else if (data_x == 8'd159) 
				begin
					data_x <= 1'b0;
					data_y <= data_y + 1'b1;
					x <= data_x;
					y <= data_y;
					color <= start_color;
				end
				
				//regular cases
				else
				begin
					data_x <= data_x + 1'b1;
					data_y <= data_y;
					x <= data_x;
					y <= data_y;
					color <= start_color;
				end
		
			end
			
			else if (datapath_target) 
			begin
				data_x <= 8'b0;
				data_y <= 7'b0;
				writeEn = 1'b1;
				//draw a random target
				if (counter_square != 7'b1000000)
					begin
					x <= 8'd100 + random_x + counter_square[2:0];
					y <= 7'd64 + counter_square[5:3];
					color <= target_color;
					counter_square <= counter_square + 1'b1;
					end
				else 
					begin
					writeEn = 1'b0;
					end
			end
				
			else if (datapath_load_angle)
			begin
				counter_square = 7'b0;
				data_x <= 8'b0;
				data_y <= 7'b0;
				angle_enable = 1'b1;
				display_angle = angle;
				writeEn = 1'b1;
				
				x <= ang_x;
				y <= ang_y;
				color <= ang_color;
				
				//let data_x memorize the data
				data_x <= ang_x;
				data_y <= ang_y;
			end
			
			else if (datapath_wait)
			begin
				counter_square = 7'b0;
				angle_enable = 1'b0;
				writeEn = 1'b0;
			end
			
			else if (datapath_load_strength)
			begin
	
				strength_enable = 1'b1;
				display_strength = strength;
				
				if (counter_square != 7'b1000000)
					begin
					writeEn = 1'b1;
					x <= s_x + counter_square[2:0];
					y <= s_y + counter_square[5:3];
					color <= s_c;
					counter_square <= counter_square + 1'b1;
					end
				else counter_square = 7'b0;
			end
			
			else if (datapath_draw)
			begin
				counter_square = 7'b0;
				strength_enable = 1'b0;
				draw_enable = 1'b1;
				writeEn = 1'b1;
				
									
				
				if (draw_y == 7'd72)
				begin
					lose = 1'b1;
				end
				
				else if (draw_x == 8'd100 + random_x)
				begin
					if(draw_y == 7'd64 
						|| draw_y == 7'd65 
						|| draw_y == 7'd66 
						|| draw_y == 7'd67 
						|| draw_y == 7'd68 
						|| draw_y == 7'd69 
						|| draw_y == 7'd70
						|| draw_y == 7'd71 
						)
							
					begin
						win = 1'b1;
						display_score = display_score + 1'b1;
					end
					
					else 
					begin
						x <= draw_x;
						y <= draw_y;
						color <= draw_color;
					end
				end
				
				else if(draw_y == 7'd64)
				begin
					if(draw_x == 8'd100 + random_x
						|| draw_x == 8'd101 + random_x
						|| draw_x == 8'd102 + random_x
						|| draw_x == 8'd103 + random_x
						|| draw_x == 8'd104 + random_x
						|| draw_x == 8'd105 + random_x
						|| draw_x == 8'd106 + random_x
						|| draw_x == 8'd107 + random_x
						)
						
					begin
						win = 1'b1;
						display_score = display_score + 1'b1;
					end
					
					else 
					begin
						x <= draw_x;
						y <= draw_y;
						color <= draw_color;
					end
				end
				
				else 
				begin
					x <= draw_x;
					y <= draw_y;
					color <= draw_color;
				end
			end
			
			else if (datapath_win)
			begin
				draw_enable = 1'b0;
				
				//draw the background
				data_x <= 8'b0;
				data_y <= 7'b0;
				writeEn = 1'b1;
				
				//draw the background 
				//when finish
				if (data_x == 8'd159 && data_y == 7'd119)
				begin
					writeEn = 1'b0;
				end
				
				//when reach end
				else if (data_x == 8'd159) 
				begin
					data_x <= 1'b0;
					data_y <= data_y + 1'b1;
					x <= data_x;
					y <= data_y;
					color <= win_color;
				end
				
				//regular cases
				else
				begin
					data_x <= data_x + 1'b1;
					data_y <= data_y;
					x <= data_x;
					y <= data_y;
					color <= win_color;
				end
			end
			
			
			else if (datapath_lose)
			begin
				draw_enable = 1'b0;
				
				//draw the background
				data_x <= 8'b0;
				data_y <= 7'b0;
				writeEn = 1'b1;
				
				//draw the background 
				//when finish
				if (data_x == 8'd159 && data_y == 7'd119)
				begin
					writeEn = 1'b0;
				end
				
				//when reach end
				else if (data_x == 8'd159) 
				begin
					data_x <= 1'b0;
					data_y <= data_y + 1'b1;
					x <= data_x;
					y <= data_y;
					color <= lose_color;
				end
				
				//regular cases
				else
				begin
					data_x <= data_x + 1'b1;
					data_y <= data_y;
					x <= data_x;
					y <= data_y;
					color <= lose_color;
				end
			end
		end
	end
			
	
endmodule

module strength_wait(
				input enable,
				input[7:0] x_in,
				input[6:0] y_in,
				input[2:0] color_in,
				output reg[7:0] x_out,
				output reg[6:0] y_out,
				output reg[2:0] color_out
				);
				
	always@ (*)
	begin
		if (!enable)
		begin
			x_out = 8'b0;
			y_out = 7'b0;
			color_out = 3'b0;
		end
		
		else 
		begin
			x_out = x_in;
			y_out = y_in;
			color_out = color_in;
		end
	end

endmodule


