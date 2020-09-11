`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2020 11:10:16 AM
// Design Name: 
// Module Name: rtsh_rs422_test_top
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


module rtsh_rs422_test_top
(
    input wire clk,
    input wire [3:0] switches,
    input wire [3:0] led,
    
    output wire FM_output,
    output wire ZTC_output,
    output wire polarity_output,
    output wire irig_output
);

localparam  PROGRAM_ID = 16'h0200,
            VERSION_LARGE = 12'd0,
            VERSION_SMALL = 4'd0;


endmodule
