`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:  RUAS
// Engineer: Dileep Nethrapalli
// 
// Create Date: 10.07.2020 17:42:43
// Design Name: 
// Module Name: Keyboard_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PS2_Mouse_to_LCD_top(
         output [7:4] LCD_DB,
         output LCD_E, LCD_RS, LCD_RW, 
         output Data_reporting_pass,
         inout  PS2_CLK, PS2_DAT,
         input  Clock_100MHz, Clear_n);          
         
         wire [7:0]   status, x_dir, y_dir;
         wire [127:0] line_1, line_2;
         
         
  PS2_Mouse mouse_DUT(
     .Status_out(status), 
     .X_Direction(x_dir), .Y_Direction(y_dir), 
     .Data_reporting_pass(Data_reporting_pass),  
     .PS2_CLK(PS2_CLK), .PS2_DAT(PS2_DAT),
     .Clock_100MHz(Clock_100MHz), .Clear_n(Clear_n)); 
                       
                      
  Decimal_to_ASCII ascii_DUT(
         .Line_1(line_1), .Line_2(line_2),
         .Status_in(status), 
         .X_Direction(x_dir), .Y_Direction(y_dir), 
         .Clock_100MHz(Clock_100MHz), .Clear_n(Clear_n));

                          
  LCD_controller_16x2 lcd_for_keyboard_DUT(
     .LCD_DB(LCD_DB), .LCD_E(LCD_E), 
     .LCD_RS(LCD_RS), .LCD_RW(LCD_RW),
     .Line_1(line_1), .Line_2(line_2),
     .Clock_100MHz(Clock_100MHz), .Clear_n(Clear_n));                        
                                                     
endmodule
