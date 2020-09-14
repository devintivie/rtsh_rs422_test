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
    input wire [31:0] period,
//    output wire [11:0] rgbs,
    output wire pulse_train
);

localparam  MAX_CLOCK_COUNT = 32'hffffffff;

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
        if(main_counter >= pulse_width)
            gen_next = 1'b0;
        else
            gen_next = 1'b1;
    end
    else
        gen_next = 1'b0;
end

assign pulse_train = gen_reg;

endmodule