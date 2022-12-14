

module enemy_missile
(
	input		logic				reset,
	input		logic	[9:0]		playerX,				//player left X coordinate
	input		logic [9:0][5:0] 	enemy_status,	//enemies that are still alive
	input		logic				vsync,				//vsync signal
	input		logic [9:0]		enemy_offset,		//offset of the enemy array
	input		logic [3:0]		state,
	input    logic [2:0]    tens,
	input    logic [17:0]   SW,
	
	
	output	logic				exists,				//whether or not the enemy missile exists
	output 	logic	[9:0]		missileX,			//enemy missile X position
	output	logic	[9:0]		missileY				//enemy missile Y position
);

	logic [7:0] missile_timer;		//counts two seconds between every missile shot
	logic [5:0] enemy_column;
	logic [3:0] column_index;
	logic [1:0] MODEL;
	
	always_ff @ (posedge vsync or posedge reset) begin

	 case(SW[2:0])
   3'b100: MODEL=3;
   3'b010: MODEL=2;
   3'b001: MODEL=1;
   default:MODEL=1;
   endcase
	
		if(reset) begin
			missile_timer = 8'd0;
			exists = 1'b0;
		end
		
		else if(state != 4'd1) begin
			missile_timer = 8'd0;
			exists = 1'b0;
		end
		
		else begin
		
			missileX = missileX;
		
			//wait for when we can send the next missile
			if(!exists&&missile_timer < 8'd30) begin
				missile_timer = missile_timer + 8'd1;
			end
			
			//if it's time, create the missile (if we can)
			else if(!exists&&missile_timer >= 8'd30) begin
			
				//have a missile shoot out from the middle
				//of the enemy
				missileX = {column_index, 6'b0} + enemy_offset + 10'd16;
				missile_timer = 8'd0;
			
				//choose the Y position to create it from, depending
				//on what the lowest enemy that is still alive
				//in the nearest column of enemies.
				if(enemy_column[5]) begin
					exists = 1'b1;
					missileY = 10'd224;
				end
				
				else if(enemy_column[4]) begin
					exists = 1'b1;
					missileY = 10'd192;
				end
				
				else if(enemy_column[3]) begin
					exists = 1'b1;
					missileY = 10'd160;
				end
				
				else if(enemy_column[2]) begin
					exists = 1'b1;
					missileY = 10'd128;
				end
				
				else if(enemy_column[1]) begin
					exists = 1'b1;
					missileY = 10'd96;
				end
				
				else if(enemy_column[0]) begin
					exists = 1'b1;
					missileY = 10'd64;
				end
				
			end
			
			//check for collision
			else if (missileY >= 480) begin
				
				exists = 1'b0;
				
			end
			
			//otherwise update y position
			else if(exists) begin
				
				missileY = missileY + MODEL+tens;
				
			end
							
		end
		
	end
	
	always_comb begin
	
		column_index = playerX[9:6];
		enemy_column = enemy_status[column_index];

	end

endmodule 