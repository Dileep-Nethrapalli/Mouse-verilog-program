`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:  RUAS
// Engineer: Dileep Nethrapalli
// 
// Create Date:    10:59:00 04/15/2021 
// Design Name: 
// Module Name:    PS2_Mouse 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PS2_Mouse(
          output reg [7:0] Status_out,  
          output reg [7:0] X_Direction, Y_Direction,
          output reg Data_reporting_pass,
          inout  PS2_CLK, PS2_DAT,
          input  Clock_100MHz, Clear_n);   
                 
   reg cen, CLK, den, DAT;
   reg resend_cmd, reset_count_11000;   
   reg [7:0]  cmd = 8'hF4; // Data Reporting 
   reg [7:0]  response, status, x_dir, y_dir;
   reg [13:0] count_11000;  
          

  // FSM for Mouse  
    reg [7:0] present_state, next_state;  
           
    parameter [7:0] 
      RESET = 8'd0,      WR_START  = 8'd1,        
      WR_DATA_0 = 8'd2,  WR_DATA_1 = 8'd3,   
      WR_DATA_2 = 8'd4,  WR_DATA_3 = 8'd5, 
      WR_DATA_4 = 8'd6,  WR_DATA_5 = 8'd7,  
      WR_DATA_6 = 8'd8,  WR_DATA_7 = 8'd9,  
      WR_PARITY = 8'd10, WR_STOP = 8'd11,  
      WR_ACK = 8'd12, 
                    
      RESP_START = 8'd13, RESP_0 = 8'd14,    
      RESP_1 = 8'd15,     RESP_2 = 8'd16,  
      RESP_3 = 8'd17,     RESP_4 = 8'd18,      
      RESP_5 = 8'd19,     RESP_6 = 8'd20,    
      RESP_7 = 8'd21,     RESP_PARITY = 8'd22, 
      RESP_STOP = 8'd23,                    
                    
      STATUS_START = 8'd24, STATUS_0 = 8'd25,    
      STATUS_1 = 8'd26,     STATUS_2 = 8'd27,
      STATUS_3 = 8'd28,     STATUS_4 = 8'd29,      
      STATUS_5 = 8'd30,     STATUS_6 = 8'd31,    
      STATUS_7 = 8'd32,     STATUS_PARITY = 8'd33,   
      STATUS_STOP = 8'd34,
                    
      X_DIR_START = 8'd35, X_DIR_0 = 8'd36,     
      X_DIR_1 = 8'd37,     X_DIR_2 = 8'd38,  
      X_DIR_3 = 8'd39,     X_DIR_4 = 8'd40,      
      X_DIR_5 = 8'd41,     X_DIR_6 = 8'd42,     
      X_DIR_7 = 8'd43,     X_DIR_PARITY = 8'd44,  
      X_DIR_STOP = 8'd45,
                   
      Y_DIR_START = 8'd46, Y_DIR_0 = 8'd47,    
      Y_DIR_1 = 8'd48,     Y_DIR_2 = 8'd49,
      Y_DIR_3 =8'd50,      Y_DIR_4 = 8'd51,
      Y_DIR_5 = 8'd52,     Y_DIR_6 = 8'd53,    
      Y_DIR_7 = 8'd54,     Y_DIR_PARITY = 8'd55,
      Y_DIR_STOP = 8'd56; 
                    
    
 // FSM registers
    always@(negedge PS2_CLK, negedge Clear_n)
      if(!Clear_n) 
         present_state <= RESET;
      else
         present_state <= next_state;          
           
 // FSM Combinational block 
 always@(present_state, PS2_DAT, cmd, count_11000, 
         Data_reporting_pass) 
  case(present_state)           
   RESET: begin 
            den = 1; DAT = 1; next_state = WR_START; 
          end  
   
   WR_START: begin
               den = 1;       
               if(count_11000 <= 10000) 
                  begin 
                    DAT = 1; next_state = present_state; 
                  end
               else 
                 begin 
                   DAT = 0; next_state = WR_DATA_0; 
                 end 
             end                             
   WR_DATA_0: begin  // LSB First
                den = 1; DAT = cmd[0]; next_state = WR_DATA_1; 
              end                                                           
   WR_DATA_1: begin 
                den = 1; DAT = cmd[1]; next_state = WR_DATA_2; 
              end                          
   WR_DATA_2: begin 
                den = 1; DAT = cmd[2]; next_state = WR_DATA_3; 
              end                       
   WR_DATA_3: begin 
                den = 1; DAT = cmd[3]; next_state = WR_DATA_4; 
              end                       
   WR_DATA_4: begin 
                den = 1; DAT = cmd[4]; next_state = WR_DATA_5; 
              end                       
   WR_DATA_5: begin 
                den = 1; DAT = cmd[5]; next_state = WR_DATA_6;
              end                                      
   WR_DATA_6: begin 
                den = 1; DAT = cmd[6]; next_state = WR_DATA_7; 
              end                                       
   WR_DATA_7: begin  // MSB Last
                den = 1; DAT = cmd[7]; next_state = WR_PARITY; 
              end                                       
   WR_PARITY: begin  // odd parity
                den = 1; DAT = 0; next_state = WR_STOP; 
              end                                                                                   
   WR_STOP:   begin 
                den = 1; DAT = 1; next_state = WR_ACK; 
              end                       
   WR_ACK:    begin 
                den = 0; DAT = 1;    
                if(!PS2_DAT) 
                   next_state = RESP_0; 
                else 
                   next_state = present_state;                 
              end

   RESP_0:      begin  // LSB First
                  den = 0; DAT = 1; next_state = RESP_1; 
                end 
   RESP_1:      begin 
                  den = 0; DAT = 1; next_state = RESP_2; 
                end 
   RESP_2:      begin 
                  den = 0; DAT = 1; next_state = RESP_3; 
                end 
   RESP_3:      begin 
                  den = 0; DAT = 1; next_state = RESP_4; 
                end 
   RESP_4:      begin 
                  den = 0; DAT = 1; next_state = RESP_5; 
                end
   RESP_5:      begin 
                  den = 0; DAT = 1; next_state = RESP_6; 
                end 
   RESP_6:      begin 
                  den = 0; DAT = 1; next_state = RESP_7; 
                end 
   RESP_7:      begin  // MSB Last
                  den = 0; DAT = 1; next_state = RESP_PARITY; 
                end 
   RESP_PARITY: begin 
                  den = 0; DAT = 1; next_state = RESP_STOP; 
                end 
   RESP_STOP:   begin 
                  den = 0; DAT = 1; 
                  if(Data_reporting_pass)
                     next_state = STATUS_START;
                  else
                     next_state = WR_START;
                end                         

   STATUS_START:  begin 
                    den = 0; DAT = 1; 
                    if(!PS2_DAT) 
                       next_state = STATUS_0;
                    else 
                       next_state = present_state; 
                  end 
   STATUS_0:      begin // LSB First
                    den = 0; DAT = 1; next_state = STATUS_1; 
                  end 
   STATUS_1:      begin 
                    den = 0; DAT = 1; next_state = STATUS_2; 
                  end 
   STATUS_2:      begin 
                    den = 0; DAT = 1; next_state = STATUS_3; 
                  end 
   STATUS_3:      begin 
                    den = 0; DAT = 1; next_state = STATUS_4; 
                  end 
   STATUS_4:      begin 
                    den = 0; DAT = 1; next_state = STATUS_5; 
                  end
   STATUS_5:      begin 
                    den = 0; DAT = 1; next_state = STATUS_6; 
                  end 
   STATUS_6:      begin 
                    den = 0; DAT = 1; next_state = STATUS_7; 
                  end 
   STATUS_7:      begin // MSB Last
                    den = 0; DAT = 1; next_state = STATUS_PARITY; 
                  end 
   STATUS_PARITY: begin 
                    den = 0; DAT = 1; next_state = STATUS_STOP; 
                  end 
   STATUS_STOP:   begin 
                    den = 0; DAT = 1; next_state = X_DIR_START; 
                  end                                              
                                
   X_DIR_START:   begin 
                    den = 0; DAT = 1;
                    if(!PS2_DAT) 
                       next_state = X_DIR_0;
                    else 
                       next_state = present_state; 
                  end 
   X_DIR_0:       begin // LSB First
                    den = 0; DAT = 1; next_state = X_DIR_1; 
                  end 
   X_DIR_1:       begin 
                    den = 0; DAT = 1; next_state = X_DIR_2; 
                  end 
   X_DIR_2:       begin 
                    den = 0; DAT = 1; next_state = X_DIR_3; 
                  end 
   X_DIR_3:       begin 
                    den = 0; DAT = 1; next_state = X_DIR_4; 
                  end
   X_DIR_4:       begin 
                    den = 0; DAT = 1; next_state = X_DIR_5; 
                  end 
   X_DIR_5:       begin 
                    den = 0; DAT = 1; next_state = X_DIR_6; 
                  end 
   X_DIR_6:       begin 
                    den = 0; DAT = 1; next_state = X_DIR_7; 
                  end 
   X_DIR_7:       begin  // MSB Last
                    den = 0; DAT = 1; next_state = X_DIR_PARITY; 
                  end 
   X_DIR_PARITY:  begin 
                    den = 0; DAT = 1; next_state = X_DIR_STOP; 
                  end 
   X_DIR_STOP:    begin
                    den = 0; DAT = 1; next_state = Y_DIR_START; 
                  end 
          
   Y_DIR_START:   begin 
                    den = 0; DAT = 1; 
                    if(!PS2_DAT) 
                       next_state = Y_DIR_0;
                    else 
                       next_state = present_state; 
                  end 
   Y_DIR_0:       begin  // LSB First
                    den = 0; DAT = 1; next_state = Y_DIR_1; 
                  end 
   Y_DIR_1:       begin 
                    den = 0; DAT = 1; next_state = Y_DIR_2; 
                  end 
   Y_DIR_2:       begin 
                    den = 0; DAT = 1; next_state = Y_DIR_3; 
                  end 
   Y_DIR_3:       begin 
                    den = 0; DAT = 1; next_state = Y_DIR_4; 
                  end 
   Y_DIR_4:       begin 
                    den = 0; DAT = 1; next_state = Y_DIR_5; 
                  end 
   Y_DIR_5:       begin 
                    den = 0; DAT = 1; next_state = Y_DIR_6;  
                  end
   Y_DIR_6:       begin 
                    den = 0; DAT = 1; next_state = Y_DIR_7; 
                  end
   Y_DIR_7:       begin  // MSB Last
                    den = 0; DAT = 1; next_state = Y_DIR_PARITY; 
                  end
   Y_DIR_PARITY:  begin 
                    den = 0; DAT = 1; next_state = Y_DIR_STOP; 
                  end 
   Y_DIR_STOP:    begin 
                    den = 0; DAT = 1; next_state = STATUS_START; 
                  end  
          
   default:       begin 
                    den = 0; DAT = 1; next_state = RESET; 
                  end                                                                           
  endcase  
       
  
  //Capture Mouse output data     
     always@(negedge PS2_CLK, negedge Clear_n)
       if(!Clear_n)
          {response, status, x_dir, y_dir} <= {32{1'b0}};
       else 
         case(present_state)
           RESP_0: response[0] <= PS2_DAT;
           RESP_1: response[1] <= PS2_DAT;
           RESP_2: response[2] <= PS2_DAT;
           RESP_3: response[3] <= PS2_DAT;
           RESP_4: response[4] <= PS2_DAT;
           RESP_5: response[5] <= PS2_DAT;
           RESP_6: response[6] <= PS2_DAT;
           RESP_7: response[7] <= PS2_DAT;          
         
           STATUS_0: status[0] <= PS2_DAT;
           STATUS_1: status[1] <= PS2_DAT;
           STATUS_2: status[2] <= PS2_DAT;
           STATUS_3: status[3] <= PS2_DAT;
           STATUS_4: status[4] <= PS2_DAT;
           STATUS_5: status[5] <= PS2_DAT;
           STATUS_6: status[6] <= PS2_DAT;
           STATUS_7: status[7] <= PS2_DAT;  
           
           X_DIR_0:  x_dir[0]  <= PS2_DAT;
           X_DIR_1:  x_dir[1]  <= PS2_DAT;
           X_DIR_2:  x_dir[2]  <= PS2_DAT;
           X_DIR_3:  x_dir[3]  <= PS2_DAT;
           X_DIR_4:  x_dir[4]  <= PS2_DAT;
           X_DIR_5:  x_dir[5]  <= PS2_DAT;
           X_DIR_6:  x_dir[6]  <= PS2_DAT;
           X_DIR_7:  x_dir[7]  <= PS2_DAT;
           
           Y_DIR_0:  y_dir[0]  <= PS2_DAT;
           Y_DIR_1:  y_dir[1]  <= PS2_DAT;
           Y_DIR_2:  y_dir[2]  <= PS2_DAT;
           Y_DIR_3:  y_dir[3]  <= PS2_DAT;
           Y_DIR_4:  y_dir[4]  <= PS2_DAT;
           Y_DIR_5:  y_dir[5]  <= PS2_DAT;
           Y_DIR_6:  y_dir[6]  <= PS2_DAT;
           Y_DIR_7:  y_dir[7]  <= PS2_DAT;
        endcase   
        
     
  // Assign output in STOP state   
     always@(posedge PS2_CLK, negedge Clear_n)       
       if(!Clear_n)
          begin   
            Data_reporting_pass <= 0;
            Status_out  <= 0; 
            X_Direction <= 0;
            Y_Direction <= 0;
          end 
       else if(present_state == RESP_PARITY) 
          if(response == 8'hFA)
             Data_reporting_pass <= 1; 
          else 
             Data_reporting_pass <= 0; 
       else if(present_state == Y_DIR_STOP)  
         begin
           Status_out  <= status;
           X_Direction <= x_dir;
           Y_Direction <= y_dir; 
         end
         
         
 // Generate Resend command
    always@(negedge Clock_100MHz, negedge Clear_n)       
      if(!Clear_n)
         resend_cmd <= 0;         
      else if(present_state == RESP_STOP) 
        if(Data_reporting_pass)
           resend_cmd <= 0; 
        else
           resend_cmd <= 1; 
      else if((reset_count_11000) && 
              (present_state == WR_START)) 
           resend_cmd <= 0;  
           

  // Create a delay of 110us
     // 100MHz = 10ns = 1; 110us = x; x = 11000;
     // 11000 = 10_1010_1111_1000b      
     always@(posedge Clock_100MHz, negedge Clear_n)
       if(!Clear_n)
         begin
           reset_count_11000 <= 0;
           count_11000 <= 0;
         end 
       else if((resend_cmd) && 
               (present_state == WR_START)) 
         begin
           reset_count_11000 <= 1;       
           count_11000 <= 0;
         end 
       else if(count_11000 == 11000)
         begin
           reset_count_11000 <= 0;
           count_11000 <= count_11000;
         end 
       else 
         begin
           reset_count_11000 <= 0;
           count_11000 <= count_11000 + 1;
         end          
          
             
 // Inhibit Communication
    always@(negedge Clock_100MHz, negedge Clear_n)
      if(!Clear_n) 
         begin cen <= 1; CLK <= 1; end
      else if((count_11000 >= 0) && 
              (count_11000 < 11000))                
         begin cen <= 1; CLK <= 0; end
      else 
         begin cen <= 0; CLK <= 1; end    
   
    
   assign PS2_CLK = (cen) ? CLK : 1'bz;  
   assign PS2_DAT = (den) ? DAT : 1'bz;     
    
endmodule
