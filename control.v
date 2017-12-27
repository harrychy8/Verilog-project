//the module for control 

module control(
			input clk,						//CLOCK_50
			input resetn,					//SW 9
			input start,					//KEY 0
			input load_target,			//KEY 1
			input load_angle,				//KEY 2
			input load_strength,			//KEY 3
			input[6:0] counter_square,
			input win,
			input lose,
			
			output reg enable_delay,
			output reg datapath_reset,
			output reg datapath_start,
			output reg datapath_target,
			output reg datapath_load_angle,
			output reg datapath_wait,
			output reg datapath_load_strength,
			output reg datapath_draw,
			output reg datapath_win,
			output reg datapath_lose
			);
		
		
	reg [4:0] current_state, next_state; 
	
	localparam  S_RESET				= 5'd1,
					S_START   			= 5'd2,
					S_TARGET				= 5'd3,
					S_WAIT1				= 5'd4,
					S_LOAD_A     		= 5'd5,
					S_WAIT2				= 5'd6,
				   S_LOAD_S				= 5'd7,
				   S_DRAW				= 5'd8,
				   S_WIN					= 5'd9,
					S_LOSE				= 5'd10;
					 
	// Next state logic aka our state table
    always@(*)
    begin: state_table 
           case (current_state)
                S_RESET: next_state = start ? S_START : S_RESET;
					 S_START: next_state = load_target ? S_TARGET : S_START;
					 S_TARGET: next_state = (counter_square == 7'b1000000) ? S_WAIT1 : S_TARGET;
					 S_WAIT1: next_state = load_angle ? S_LOAD_A : S_WAIT1;
					 S_LOAD_A: next_state = ~load_angle ? S_WAIT2 : S_LOAD_A;
					 S_WAIT2: next_state = load_strength ? S_LOAD_S : S_WAIT2;
					 S_LOAD_S: next_state = ~load_strength ? S_DRAW : S_LOAD_S;
					 S_DRAW: if (win) next_state = S_WIN;
								else if (lose) next_state = S_LOSE;
								else next_state = S_DRAW;
								
					 S_WIN: if (start) next_state = S_START;
								 else next_state = S_WIN;
						
					 S_LOSE: if (start) next_state = S_START;
								 else next_state = S_LOSE;
									
            default:     next_state = S_RESET;
        endcase
    end // state_table
	 
	 
	 // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
		// By default make all our signals 0
		datapath_reset = 1'b0;
		datapath_start = 1'b0;
		datapath_target = 1'b0;
		datapath_load_angle = 1'b0;
		datapath_wait = 1'b0;
		datapath_load_strength = 1'b0;
		datapath_draw = 1'b0;
		datapath_win = 1'b0;	
		datapath_lose = 1'b0;
		enable_delay = 1'b0;
		
      case (current_state)
				S_RESET: 
				begin
					datapath_reset = 1'b1;
            end
				
				S_START: 
				begin
					datapath_start = 1'b1;
				end
				
				S_TARGET:
				begin
					datapath_target = 1'b1;
				end
				
				S_WAIT1:
				begin
					datapath_target = 1'b0;
				end
				
				S_LOAD_A:
				begin
					datapath_load_angle = 1'b1;
				end
				
				S_WAIT2: 
				begin
					datapath_load_angle = 1'b0;
				end
				
				S_LOAD_S:
				begin
					datapath_load_strength = 1'b1;
				end
				
            S_DRAW: 
				begin
					datapath_draw = 1'b1;
            end
				
				S_WIN:
				begin
					datapath_win = 1'b1;
				end
				
				S_LOSE:
				begin 
					datapath_lose = 1'b1;
				end
				
        endcase
    end // enable_signals
	 
	 
	 // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_RESET;
        else
            current_state <= next_state;
    end // state_FFS
endmodule

