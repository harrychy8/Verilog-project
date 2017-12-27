//top module 

module top(
		SW,
		KEY,
		CLOCK_50,
		LEDR,
		HEX0,
		HEX1,
		HEX2,
		HEX3,
		HEX4,
		HEX5,
		
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
		);

	input[9:0] SW;
	input[3:0] KEY;
	input CLOCK_50;
	
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	output[9:0] LEDR;
	output[6:0] HEX0;
	output[6:0] HEX1;
	output[6:0] HEX2;
	output[6:0] HEX3;
	output[6:0] HEX4;
	output[6:0] HEX5;
	
	wire[7:0] display_angle;
	wire[7:0] display_strength;
	wire[7:0] display_score;

	wire[6:0] counter_square;
	//input keys
	wire start = ~KEY[0];
	wire load_t = ~KEY[1];
	wire load_a = ~KEY[2];
	wire load_s = ~KEY[3];
	
	wire data_delay,data_r, data_s, data_t, data_la, data_w, data_ls, data_d, data_win, data_lose;
	wire win, lose;
				
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;
	
	control c0(
				//inputs
				.clk(CLOCK_50),
				.resetn(SW[9]),
				.start(start),
				.load_target(load_t),
				.load_angle(load_a),
				.load_strength(load_s),
				.counter_square(counter_square),
				.win(win),
				.lose(lose),
				//outputs
				.enable_delay(data_delay),
				.datapath_reset(data_r),
				.datapath_start(data_s),
				.datapath_target(data_t),
				.datapath_load_angle(data_la),
				.datapath_wait(data_w),
				.datapath_load_strength(data_ls),
				.datapath_draw(data_d),
				.datapath_win(data_win),
				.datapath_lose(data_lose)
				);
				
	datapath d0(
				//inputs
				.clk(CLOCK_50),
				.resetn(SW[9]),
				.datapath_reset(data_r),
				.datapath_start(data_s),
				.datapath_target(data_t),
				.datapath_load_angle(data_la),
				.datapath_wait(data_w),
				.datapath_load_strength(data_ls),
				.datapath_draw(data_d),
				.datapath_win(data_win),
				.datapath_lose(data_lose),
				
				//outputs
				.counter_square(counter_square),
				.display_angle(display_angle),
				.display_strength(display_strength),
				.display_score(display_score),
				.x(x),
				.y(y),
				.color(colour),
				.writeEn(writeEn),
				.win(win),
				.lose(lose)
				);	
					
	
	//display angle 
	seven_Segement_Decoder h5(HEX5,display_angle[7:4]);
	seven_Segement_Decoder h4(HEX4,display_angle[3:0]);
	
	//display strength
	seven_Segement_Decoder h3(HEX3,display_strength[7:4]);
	seven_Segement_Decoder h2(HEX2,display_strength[3:0]);
	
	//display score
	seven_Segement_Decoder h1(HEX1,display_score[7:4]);
	seven_Segement_Decoder h0(HEX0,display_score[3:0]);
	

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(SW[9]),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
	
endmodule
					