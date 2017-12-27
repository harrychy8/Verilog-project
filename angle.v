//this module is one of state which ask the player to input the angle

module getAngle(
				input enable, 
				input clk, 
				output[7:0] angle,
				output[7:0] x,
				output[6:0] y,
				output[2:0] color
				);

	wire next;
	counter c0(clk,enable,next);
	
	//initial value
	reg add = 1'b1;
	reg[7:0] result = 8'b0;
	reg [7:0]xend = 8'd78;//42
	reg [6:0]yend = 7'd64;//28;
	reg [2:0]ang_color = 3'b0;

	always@ (posedge next, negedge enable)
	begin
		if (!enable) //reset the data
		begin
			add = 1'b1;
			result = 8'b0;
			xend = 8'd60;
			yend = 7'd64;
			ang_color = 3'b0;
		end
		
		else
		begin
			if (add)
			begin 
				result = result + 8'd5; //add 15 degree
				xend = xend - 1'd1;
				yend = yend - 1'd1;

				if (result == 8'd90) //if reach 90 degree, change to minus
				begin
					add = ~add;
					ang_color = 3'b111;
				end
			end 
			
			else 
			begin 
				result = result - 8'd5; //minus 15 degree
				xend = xend + 1'd1;
				yend = yend + 1'd1; //minus 2 pix degree
				
				if (result == 8'd0) //if reach 0 degree
				begin 
					add = ~add;
					ang_color = 3'b000;
				end
			end
		end
	end
	
	assign angle = result;
	assign x = xend;
	assign y = yend;
	assign color = ang_color;
	
endmodule 