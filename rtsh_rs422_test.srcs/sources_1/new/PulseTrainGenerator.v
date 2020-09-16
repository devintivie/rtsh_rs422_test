`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2020 11:34:51 AM
// Design Name: 
// Module Name: PulseTrainGenerator
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


module PulseTrainGenerator
(
    input wire clk,
    input wire enable,
    input wire [31:0] main_counter,
    input wire [31:0] pulse_width,
    input wire [31:0] delay,
    input wire [31:0] period,
    input wire polarity,
//    output wire [11:0] rgbs,
    output wire pulse_train
);

localparam  MAX_CLOCK_COUNT = 32'hffffffff;
localparam INIT_DELAY = 16'd50;
reg gen_reg, gen_next;

always @(posedge clk)
begin
   gen_reg <= gen_next; 
end

always@*
begin
     //clock counter
    if(enable == 1'b1)
    begin
        if(main_counter < INIT_DELAY)
            gen_next = 1'b0;
        else if(main_counter <= pulse_width + INIT_DELAY)
            gen_next = 1'b1;   
        else if(main_counter <= pulse_width + INIT_DELAY + delay)
            gen_next = 1'b0;
        else if(main_counter <= pulse_width*2 + INIT_DELAY + delay)
            gen_next = 1'b1;     
        else if(main_counter <= pulse_width*2 + INIT_DELAY + delay*2)
            gen_next = 1'b0;
        else if(main_counter <= pulse_width*3 + INIT_DELAY + delay*2)
            gen_next = 1'b1;  
        else
            gen_next = 1'b0;
    end
    else
        gen_next = 1'b0;
end

assign pulse_train = gen_reg ^ polarity;

endmodule