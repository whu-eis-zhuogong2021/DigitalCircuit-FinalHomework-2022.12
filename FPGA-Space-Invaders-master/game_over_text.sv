module game_over_text_map
(
	input logic [5:0] X,
	input logic [4:0] Y,
	output logic pixel
);

	logic [7:0] rom_address;
	logic [7:0] text_slice;
	
	assign pixel = text_slice[3'b111 - X[2:0]];
	
	game_over_rom gor(.address(rom_address), .data(text_slice));

	always_comb begin
	
		if(X >= 6'd0 && X < 6'd8 && Y >= 5'd0 && Y < 5'd16)
			rom_address = 8'd0 + Y;
		
		else if(X >= 6'd8 && X < 6'd16 && Y >= 5'd0 && Y < 5'd16)
			rom_address = 8'd16 + Y;
		
		else if(X >= 6'd16 && X < 6'd24 && Y >= 5'd0 && Y < 5'd16)
			rom_address = 8'd32 + Y;
		
		else if(X >= 6'd24 && X < 6'd32 && Y >= 5'd0 && Y < 5'd16)
			rom_address = 8'd48 + Y;
		
		
		
		
		
		else if(X >= 6'd0 && X < 6'd8 && Y >= 5'd16)
			rom_address = 8'd64 + Y - 8'd16;
		
		else if(X >= 6'd8 && X < 6'd16 && Y >= 5'd16)
			rom_address = 8'd80 + Y - 8'd16;
	
		else if(X >= 6'd16 && X < 6'd24 && Y >= 5'd16)
			rom_address = 8'd96 + Y - 8'd16;
		
		//else if(X >= 6'd24 && X < 6'd32 && Y >= 5'd16 && Y < 5'd32)
		else
			rom_address = 8'd112 + Y - 8'd16;
					
	end

endmodule 

module game_over_rom
(
	input [7:0] address,
	output [7:0] data
);

	parameter[0:127][7:0] ROM = {
        8'b00000000, // 0
        8'b00000000, // 1
        8'b00111100, // 2   ****
        8'b01100110, // 3  **  **
        8'b11000010, // 4 **    *
        8'b11000000, // 5 **
        8'b11000000, // 6 **
        8'b11011110, // 7 ** ****
        8'b11000110, // 8 **   **
        8'b11000110, // 9 **   **
        8'b01100110, // a  **  **
        8'b00111010, // b   *** *
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b00010000, // 2    *
        8'b00111000, // 3   ***
        8'b01101100, // 4  ** **
        8'b11000110, // 5 **   **
        8'b11000110, // 6 **   **
        8'b11111110, // 7 *******
        8'b11000110, // 8 **   **
        8'b11000110, // 9 **   **
        8'b11000110, // a **   **
        8'b11000110, // b **   **
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f		  
        8'b00000000, // 0
        8'b00000000, // 1
        8'b11000011, // 2 **    **
        8'b11100111, // 3 ***  ***
        8'b11111111, // 4 ********
        8'b11111111, // 5 ********
        8'b11011011, // 6 ** ** **
        8'b11000011, // 7 **    **
        8'b11000011, // 8 **    **
        8'b11000011, // 9 **    **
        8'b11000011, // a **    **
        8'b11000011, // b **    **
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b11111110, // 2 *******
        8'b01100110, // 3  **  **
        8'b01100010, // 4  **   *
        8'b01101000, // 5  ** *
        8'b01111000, // 6  ****
        8'b01101000, // 7  ** *
        8'b01100000, // 8  **
        8'b01100010, // 9  **   *
        8'b01100110, // a  **  **
        8'b11111110, // b *******
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
        8'b00000000, // 0
        8'b00000000, // 1
        8'b01111100, // 2  *****
        8'b11000110, // 3 **   **
        8'b11000110, // 4 **   **
        8'b11000110, // 5 **   **
        8'b11000110, // 6 **   **
        8'b11000110, // 7 **   **
        8'b11000110, // 8 **   **
        8'b11000110, // 9 **   **
        8'b11000110, // a **   **
        8'b01111100, // b  *****
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f	
        8'b00000000, // 0
        8'b00000000, // 1
        8'b11000011, // 2 **    **
        8'b11000011, // 3 **    **
        8'b11000011, // 4 **    **
        8'b11000011, // 5 **    **
        8'b11000011, // 6 **    **
        8'b11000011, // 7 **    **
        8'b11000011, // 8 **    **
        8'b01100110, // 9  **  **
        8'b00111100, // a   ****
        8'b00011000, // b    **
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
		  8'b00000000, // 0  
        8'b00000000, // 1
        8'b11111110, // 2 *******
        8'b01100110, // 3  **  **
        8'b01100010, // 4  **   *
        8'b01101000, // 5  ** *
        8'b01111000, // 6  ****
        8'b01101000, // 7  ** *
        8'b01100000, // 8  **
        8'b01100010, // 9  **   *
        8'b01100110, // a  **  **
        8'b11111110, // b *******
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f 
        8'b00000000, // 0
        8'b00000000, // 1
        8'b11111100, // 2 ******
        8'b01100110, // 3  **  **
        8'b01100110, // 4  **  **
        8'b01100110, // 5  **  **
        8'b01111100, // 6  *****
        8'b01101100, // 7  ** **
        8'b01100110, // 8  **  **
        8'b01100110, // 9  **  **
        8'b01100110, // a  **  **
        8'b11100110, // b ***  **
        8'b00000000, // c
        8'b00000000, // d
        8'b00000000, // e
        8'b00000000, // f
	};
	
	assign data = ROM[address];

endmodule 