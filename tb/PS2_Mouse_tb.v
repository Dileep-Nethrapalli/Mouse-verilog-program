`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company:  RUAS
// Engineer: Dileep Nethrapalli
//
// Create Date:   09:52:08 04/16/2021
// Design Name:   PS2_Mouse
// Module Name:   D:/Dileep/Mouse_Virtex_5/run/ps2_mouse/PS2_Mouse_tb.v
// Project Name:  ps2_mouse
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PS2_Mouse
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PS2_Mouse_tb;

	// Inputs
	reg Clock_100MHz;
	reg Clear_n;

	// Outputs
   wire [13:0] count_11000;
	wire [7:0]  Status, X_Dir, Y_Dir, present_state_tb;

	// Bidirs
	wire PS2_CLK;
	wire PS2_DAT;
   
   // Design signals 
    reg  ps2_clock;
    wire clock_en; 
    wire Data_reporting_pass;

	// Instantiate the Unit Under Test (UUT)
	PS2_Mouse uut (
		.Status_out(Status), 
      .X_Direction(X_Dir), 
      .Y_Direction(Y_Dir), 
      .Data_reporting_pass(Data_reporting_pass),
		.PS2_CLK(PS2_CLK), 
		.PS2_DAT(PS2_DAT), 
		.Clock_100MHz(Clock_100MHz), 
		.Clear_n(Clear_n)
	);

	initial begin
		// Initialize Inputs
		Clock_100MHz = 0;
		Clear_n = 0;

		// Wait 100 ns for global reset to finish
		#100     Clear_n = 1;
      #1500000 $finish;  
		// Add stimulus here
	end
   
  
  always #5 Clock_100MHz = ~Clock_100MHz;

   
  // 75 us clock = 32.5us On + 32.5us Off
   initial ps2_clock = 0;  
   always #32500 ps2_clock = ~ps2_clock;    

   assign PS2_CLK = (~clock_en) ? ps2_clock : 1'bz;  
   
   assign PS2_DAT = ((present_state_tb == 12) || (present_state_tb == 13) ||
                     (present_state_tb == 24) || (present_state_tb == 35) ||
                     (present_state_tb == 46)) ? 0 : 1'bz;
      
   assign present_state_tb = uut.present_state;   
   assign count_11000 = uut.count_11000;
   assign clock_en = uut.cen;
   
endmodule

