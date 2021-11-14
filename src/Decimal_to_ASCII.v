`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:  RUAS
// Engineer: Dileep Nethrapalli
// 
// Create Date:    10:01:09 12/17/2020 
// Design Name: 
// Module Name:    LCD_controller 
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
module Decimal_to_ASCII(
         output reg [127:0] Line_1, Line_2,
         input  [7:0] Status_in, X_Direction, Y_Direction,
         input  Clock_100MHz, Clear_n); 
   

 // Convert Mouse status signal to ASCII for LCD    
    reg [63:0] status;

  always@(negedge Clock_100MHz, negedge Clear_n)
    if(!Clear_n)             
      status <= {(64){1'b0}}; 
    else 
      begin
        if(Status_in[0]) 
          status[7:0] <= 8'h31; // 1
        else          
          status[7:0] <= 8'h30; // 0
        if(Status_in[1]) 
           status[15:8] <= 8'h31; 
        else           
           status[15:8] <= 8'h30; 
        if(Status_in[2]) 
           status[23:16] <= 8'h31; 
        else       
           status[23:16] <= 8'h30;          
        if(Status_in[3]) 
           status[31:24] <= 8'h31; 
        else    
           status[31:24] <= 8'h30;  
        if(Status_in[4])
           status[39:32] <= 8'h31; 
        else  
           status[39:32] <= 8'h30;
        if(Status_in[5]) 
           status[47:40] <= 8'h31; 
        else        
           status[47:40] <= 8'h30; 
        if(Status_in[6]) 
           status[55:48] <= 8'h31; 
        else       
           status[55:48] <= 8'h30;          
        if(Status_in[7]) 
           status[63:56] <= 8'h31; 
        else        
           status[63:56] <= 8'h30;         
      end 
      

 // Convert Decimal X-Dir and Y-Dir signals to ASCII for LCD  
    reg [23:0] x_dir, y_dir;

  always@(negedge Clock_100MHz, negedge Clear_n)
    if(!Clear_n)  
       begin    
         x_dir <= {(24){1'b0}}; 
         y_dir <= {(24){1'b0}}; 
       end  
    else 
      begin
        Decimal_to_ASCII(x_dir, X_Direction);        
        Decimal_to_ASCII(y_dir, Y_Direction);         
      end  
   
 
  task Decimal_to_ASCII(
        output [23:0] ascii,
        input  [7:0]  decimal);           
 
      case(decimal)
        0: ascii <= {8'h30, 8'h20, 8'h20};
        1: ascii <= {8'h31, 8'h20, 8'h20};       
        2: ascii <= {8'h32, 8'h20, 8'h20};
        3: ascii <= {8'h33, 8'h20, 8'h20};
        4: ascii <= {8'h34, 8'h20, 8'h20};       
        5: ascii <= {8'h35, 8'h20, 8'h20}; 
        6: ascii <= {8'h36, 8'h20, 8'h20};
        7: ascii <= {8'h37, 8'h20, 8'h20};       
        8: ascii <= {8'h38, 8'h20, 8'h20};        
        9: ascii <= {8'h39, 8'h20, 8'h20}; 
        
        10: ascii <= {8'h31, 8'h30, 8'h20};
        11: ascii <= {8'h31, 8'h31, 8'h20};       
        12: ascii <= {8'h31, 8'h32, 8'h20};
        13: ascii <= {8'h31, 8'h33, 8'h20};
        14: ascii <= {8'h31, 8'h34, 8'h20};       
        15: ascii <= {8'h31, 8'h35, 8'h20}; 
        16: ascii <= {8'h31, 8'h36, 8'h20};
        17: ascii <= {8'h31, 8'h37, 8'h20};       
        18: ascii <= {8'h31, 8'h38, 8'h20};        
        19: ascii <= {8'h31, 8'h39, 8'h20}; 
        
        20: ascii <= {8'h32, 8'h30, 8'h20};
        21: ascii <= {8'h32, 8'h31, 8'h20};       
        22: ascii <= {8'h32, 8'h32, 8'h20};
        23: ascii <= {8'h32, 8'h33, 8'h20};
        24: ascii <= {8'h32, 8'h34, 8'h20};       
        25: ascii <= {8'h32, 8'h35, 8'h20}; 
        26: ascii <= {8'h32, 8'h36, 8'h20};
        27: ascii <= {8'h32, 8'h37, 8'h20};       
        28: ascii <= {8'h32, 8'h38, 8'h20};        
        29: ascii <= {8'h32, 8'h39, 8'h20};
        
        30: ascii <= {8'h33, 8'h30, 8'h20};
        31: ascii <= {8'h33, 8'h31, 8'h20};       
        32: ascii <= {8'h33, 8'h32, 8'h20};
        33: ascii <= {8'h33, 8'h33, 8'h20};
        34: ascii <= {8'h33, 8'h34, 8'h20};       
        35: ascii <= {8'h33, 8'h35, 8'h20}; 
        36: ascii <= {8'h33, 8'h36, 8'h20};
        37: ascii <= {8'h33, 8'h37, 8'h20};       
        38: ascii <= {8'h33, 8'h38, 8'h20};        
        39: ascii <= {8'h33, 8'h39, 8'h20}; 
        
        40: ascii <= {8'h34, 8'h30, 8'h20};
        41: ascii <= {8'h34, 8'h31, 8'h20};       
        42: ascii <= {8'h34, 8'h32, 8'h20};
        43: ascii <= {8'h34, 8'h33, 8'h20};
        44: ascii <= {8'h34, 8'h34, 8'h20};       
        45: ascii <= {8'h34, 8'h35, 8'h20}; 
        46: ascii <= {8'h34, 8'h36, 8'h20};
        47: ascii <= {8'h34, 8'h37, 8'h20};       
        48: ascii <= {8'h34, 8'h38, 8'h20};        
        49: ascii <= {8'h34, 8'h39, 8'h20};        
        
        50: ascii <= {8'h35, 8'h30, 8'h20};
        51: ascii <= {8'h35, 8'h31, 8'h20};       
        52: ascii <= {8'h35, 8'h32, 8'h20};
        53: ascii <= {8'h35, 8'h33, 8'h20};
        54: ascii <= {8'h35, 8'h34, 8'h20};       
        55: ascii <= {8'h35, 8'h35, 8'h20}; 
        56: ascii <= {8'h35, 8'h36, 8'h20};
        57: ascii <= {8'h35, 8'h37, 8'h20};       
        58: ascii <= {8'h35, 8'h38, 8'h20};        
        59: ascii <= {8'h35, 8'h39, 8'h20};  

        60: ascii <= {8'h36, 8'h30, 8'h20};
        61: ascii <= {8'h36, 8'h31, 8'h20};       
        62: ascii <= {8'h36, 8'h32, 8'h20};
        63: ascii <= {8'h36, 8'h33, 8'h20};
        64: ascii <= {8'h36, 8'h34, 8'h20};       
        65: ascii <= {8'h36, 8'h35, 8'h20}; 
        66: ascii <= {8'h36, 8'h36, 8'h20};
        67: ascii <= {8'h36, 8'h37, 8'h20};       
        68: ascii <= {8'h36, 8'h38, 8'h20};        
        69: ascii <= {8'h36, 8'h39, 8'h20};        

        70: ascii <= {8'h37, 8'h30, 8'h20};
        71: ascii <= {8'h37, 8'h31, 8'h20};       
        72: ascii <= {8'h37, 8'h32, 8'h20};
        73: ascii <= {8'h37, 8'h33, 8'h20};
        74: ascii <= {8'h37, 8'h34, 8'h20};       
        75: ascii <= {8'h37, 8'h35, 8'h20}; 
        76: ascii <= {8'h37, 8'h36, 8'h20};
        77: ascii <= {8'h37, 8'h37, 8'h20};       
        78: ascii <= {8'h37, 8'h38, 8'h20};        
        79: ascii <= {8'h37, 8'h39, 8'h20};        
        
        80: ascii <= {8'h38, 8'h30, 8'h20};
        81: ascii <= {8'h38, 8'h31, 8'h20};       
        82: ascii <= {8'h38, 8'h32, 8'h20};
        83: ascii <= {8'h38, 8'h33, 8'h20};
        84: ascii <= {8'h38, 8'h34, 8'h20};       
        85: ascii <= {8'h38, 8'h35, 8'h20}; 
        86: ascii <= {8'h38, 8'h36, 8'h20};
        87: ascii <= {8'h38, 8'h37, 8'h20};       
        88: ascii <= {8'h38, 8'h38, 8'h20};        
        89: ascii <= {8'h38, 8'h39, 8'h20};        
        
        90: ascii <= {9'h39, 9'h30, 9'h20};
        91: ascii <= {9'h39, 9'h31, 9'h20};       
        92: ascii <= {9'h39, 9'h32, 9'h20};
        93: ascii <= {9'h39, 9'h33, 9'h20};
        94: ascii <= {9'h39, 9'h34, 9'h20};       
        95: ascii <= {9'h39, 9'h35, 9'h20}; 
        96: ascii <= {9'h39, 9'h36, 9'h20};
        97: ascii <= {9'h39, 9'h37, 9'h20};       
        98: ascii <= {9'h39, 9'h38, 9'h20};        
        99: ascii <= {9'h39, 9'h39, 9'h20};        
        
        100: ascii <= {8'h31, 8'h30, 8'h30};
        101: ascii <= {8'h31, 8'h30, 8'h31};       
        102: ascii <= {8'h31, 8'h30, 8'h32};
        103: ascii <= {8'h31, 8'h30, 8'h33};
        104: ascii <= {8'h31, 8'h30, 8'h34};       
        105: ascii <= {8'h31, 8'h30, 8'h35}; 
        106: ascii <= {8'h31, 8'h30, 8'h36};
        107: ascii <= {8'h31, 8'h30, 8'h37};       
        108: ascii <= {8'h31, 8'h30, 8'h38};        
        109: ascii <= {8'h31, 8'h30, 8'h39};        
        
        110: ascii <= {8'h31, 8'h31, 8'h30};
        111: ascii <= {8'h31, 8'h31, 8'h31};       
        112: ascii <= {8'h31, 8'h31, 8'h32};
        113: ascii <= {8'h31, 8'h31, 8'h33};
        114: ascii <= {8'h31, 8'h31, 8'h34};       
        115: ascii <= {8'h31, 8'h31, 8'h35}; 
        116: ascii <= {8'h31, 8'h31, 8'h36};
        117: ascii <= {8'h31, 8'h31, 8'h37};       
        118: ascii <= {8'h31, 8'h31, 8'h38};        
        119: ascii <= {8'h31, 8'h31, 8'h39};   

        120: ascii <= {8'h31, 8'h32, 8'h30};
        121: ascii <= {8'h31, 8'h32, 8'h31};       
        122: ascii <= {8'h31, 8'h32, 8'h32};
        123: ascii <= {8'h31, 8'h32, 8'h33};
        124: ascii <= {8'h31, 8'h32, 8'h34};       
        125: ascii <= {8'h31, 8'h32, 8'h35}; 
        126: ascii <= {8'h31, 8'h32, 8'h36};
        127: ascii <= {8'h31, 8'h32, 8'h37};       
        128: ascii <= {8'h31, 8'h32, 8'h38};        
        129: ascii <= {8'h31, 8'h32, 8'h39};  

        130: ascii <= {8'h31, 8'h33, 8'h30};
        131: ascii <= {8'h31, 8'h33, 8'h31};       
        132: ascii <= {8'h31, 8'h33, 8'h32};
        133: ascii <= {8'h31, 8'h33, 8'h33};
        134: ascii <= {8'h31, 8'h33, 8'h34};       
        135: ascii <= {8'h31, 8'h33, 8'h35}; 
        136: ascii <= {8'h31, 8'h33, 8'h36};
        137: ascii <= {8'h31, 8'h33, 8'h37};       
        138: ascii <= {8'h31, 8'h33, 8'h38};        
        139: ascii <= {8'h31, 8'h33, 8'h39};   

        140: ascii <= {8'h31, 8'h34, 8'h30};
        141: ascii <= {8'h31, 8'h34, 8'h31};       
        142: ascii <= {8'h31, 8'h34, 8'h32};
        143: ascii <= {8'h31, 8'h34, 8'h33};
        144: ascii <= {8'h31, 8'h34, 8'h34};       
        145: ascii <= {8'h31, 8'h34, 8'h35}; 
        146: ascii <= {8'h31, 8'h34, 8'h36};
        147: ascii <= {8'h31, 8'h34, 8'h37};       
        148: ascii <= {8'h31, 8'h34, 8'h38};        
        149: ascii <= {8'h31, 8'h34, 8'h39};   

        150: ascii <= {8'h31, 8'h35, 8'h30};
        151: ascii <= {8'h31, 8'h35, 8'h31};       
        152: ascii <= {8'h31, 8'h35, 8'h32};
        153: ascii <= {8'h31, 8'h35, 8'h33};
        154: ascii <= {8'h31, 8'h35, 8'h34};       
        155: ascii <= {8'h31, 8'h35, 8'h35}; 
        156: ascii <= {8'h31, 8'h35, 8'h36};
        157: ascii <= {8'h31, 8'h35, 8'h37};       
        158: ascii <= {8'h31, 8'h35, 8'h38};        
        159: ascii <= {8'h31, 8'h35, 8'h39};   

        160: ascii <= {8'h31, 8'h36, 8'h30};
        161: ascii <= {8'h31, 8'h36, 8'h31};       
        162: ascii <= {8'h31, 8'h36, 8'h32};
        163: ascii <= {8'h31, 8'h36, 8'h33};
        164: ascii <= {8'h31, 8'h36, 8'h34};       
        165: ascii <= {8'h31, 8'h36, 8'h35}; 
        166: ascii <= {8'h31, 8'h36, 8'h36};
        167: ascii <= {8'h31, 8'h36, 8'h37};       
        168: ascii <= {8'h31, 8'h36, 8'h38};        
        169: ascii <= {8'h31, 8'h36, 8'h39}; 

        170: ascii <= {8'h31, 8'h37, 8'h30};
        171: ascii <= {8'h31, 8'h37, 8'h31};       
        172: ascii <= {8'h31, 8'h37, 8'h32};
        173: ascii <= {8'h31, 8'h37, 8'h33};
        174: ascii <= {8'h31, 8'h37, 8'h34};       
        175: ascii <= {8'h31, 8'h37, 8'h35}; 
        176: ascii <= {8'h31, 8'h37, 8'h36};
        177: ascii <= {8'h31, 8'h37, 8'h37};       
        178: ascii <= {8'h31, 8'h37, 8'h38};        
        179: ascii <= {8'h31, 8'h37, 8'h39};   

        180: ascii <= {8'h31, 8'h38, 8'h30};
        181: ascii <= {8'h31, 8'h38, 8'h31};       
        182: ascii <= {8'h31, 8'h38, 8'h32};
        183: ascii <= {8'h31, 8'h38, 8'h33};
        184: ascii <= {8'h31, 8'h38, 8'h34};       
        185: ascii <= {8'h31, 8'h38, 8'h35}; 
        186: ascii <= {8'h31, 8'h38, 8'h36};
        187: ascii <= {8'h31, 8'h38, 8'h37};       
        188: ascii <= {8'h31, 8'h38, 8'h38};        
        189: ascii <= {8'h31, 8'h38, 8'h39}; 

        190: ascii <= {8'h31, 8'h39, 8'h30};
        191: ascii <= {8'h31, 8'h39, 8'h31};       
        192: ascii <= {8'h31, 8'h39, 8'h32};
        193: ascii <= {8'h31, 8'h39, 8'h33};
        194: ascii <= {8'h31, 8'h39, 8'h34};       
        195: ascii <= {8'h31, 8'h39, 8'h35}; 
        196: ascii <= {8'h31, 8'h39, 8'h36};
        197: ascii <= {8'h31, 8'h39, 8'h37};       
        198: ascii <= {8'h31, 8'h39, 8'h38};        
        199: ascii <= {8'h31, 8'h39, 8'h39};   

        200: ascii <= {8'h32, 8'h30, 8'h30};
        201: ascii <= {8'h32, 8'h30, 8'h31};       
        202: ascii <= {8'h32, 8'h30, 8'h32};
        203: ascii <= {8'h32, 8'h30, 8'h33};
        204: ascii <= {8'h32, 8'h30, 8'h34};       
        205: ascii <= {8'h32, 8'h30, 8'h35}; 
        206: ascii <= {8'h32, 8'h30, 8'h36};
        207: ascii <= {8'h32, 8'h30, 8'h37};       
        208: ascii <= {8'h32, 8'h30, 8'h38};        
        209: ascii <= {8'h32, 8'h30, 8'h39};  
        
        210: ascii <= {8'h32, 8'h31, 8'h30};
        211: ascii <= {8'h32, 8'h31, 8'h31};       
        212: ascii <= {8'h32, 8'h31, 8'h32};
        213: ascii <= {8'h32, 8'h31, 8'h33};
        214: ascii <= {8'h32, 8'h31, 8'h34};       
        215: ascii <= {8'h32, 8'h31, 8'h35}; 
        216: ascii <= {8'h32, 8'h31, 8'h36};
        217: ascii <= {8'h32, 8'h31, 8'h37};       
        218: ascii <= {8'h32, 8'h31, 8'h38};        
        219: ascii <= {8'h32, 8'h31, 8'h39};  
        
        220: ascii <= {8'h32, 8'h32, 8'h30};
        221: ascii <= {8'h32, 8'h32, 8'h31};       
        222: ascii <= {8'h32, 8'h32, 8'h32};
        223: ascii <= {8'h32, 8'h32, 8'h33};
        224: ascii <= {8'h32, 8'h32, 8'h34};       
        225: ascii <= {8'h32, 8'h32, 8'h35}; 
        226: ascii <= {8'h32, 8'h32, 8'h36};
        227: ascii <= {8'h32, 8'h32, 8'h37};       
        228: ascii <= {8'h32, 8'h32, 8'h38};        
        229: ascii <= {8'h32, 8'h32, 8'h39};  
        
        230: ascii <= {8'h32, 8'h33, 8'h30};
        231: ascii <= {8'h32, 8'h33, 8'h31};       
        232: ascii <= {8'h32, 8'h33, 8'h32};
        233: ascii <= {8'h32, 8'h33, 8'h33};
        234: ascii <= {8'h32, 8'h33, 8'h34};       
        235: ascii <= {8'h32, 8'h33, 8'h35}; 
        236: ascii <= {8'h32, 8'h33, 8'h36};
        237: ascii <= {8'h32, 8'h33, 8'h37};       
        238: ascii <= {8'h32, 8'h33, 8'h38};        
        239: ascii <= {8'h32, 8'h33, 8'h39};  

        240: ascii <= {8'h32, 8'h34, 8'h30};
        241: ascii <= {8'h32, 8'h34, 8'h31};       
        242: ascii <= {8'h32, 8'h34, 8'h32};
        243: ascii <= {8'h32, 8'h34, 8'h33};
        244: ascii <= {8'h32, 8'h34, 8'h34};       
        245: ascii <= {8'h32, 8'h34, 8'h35}; 
        246: ascii <= {8'h32, 8'h34, 8'h36};
        247: ascii <= {8'h32, 8'h34, 8'h37};       
        248: ascii <= {8'h32, 8'h34, 8'h38};        
        249: ascii <= {8'h32, 8'h34, 8'h39}; 

        250: ascii <= {8'h32, 8'h35, 8'h30};
        251: ascii <= {8'h32, 8'h35, 8'h31};       
        252: ascii <= {8'h32, 8'h35, 8'h32};
        253: ascii <= {8'h32, 8'h35, 8'h33};
        254: ascii <= {8'h32, 8'h35, 8'h34};       
        255: ascii <= {8'h32, 8'h35, 8'h35};
      endcase
  endtask
  
  
 // Genarate Line 1 and Line 2 signals for LCD
  always@(posedge Clock_100MHz, negedge Clear_n)
    if(!Clear_n)  
       begin    
         Line_1 <= {(128){1'b0}}; 
         Line_2 <= {(128){1'b0}};
       end         
    else 
      begin
                  // Status =             
        Line_1 <= {64'h53_74_61_74_75_73_3D_20, status};  
        Line_2 <= {{32'h58_20_3D_20, x_dir, 16'h20_20}, 
                   {32'h59_20_3D_20, y_dir}};
      end
  
endmodule
