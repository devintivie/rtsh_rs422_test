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
    output wire [3:0] led,
//    output wire [11:0] rgbs,
    output wire FM_output,
    output wire ZTC_output,
    output wire polarity_output,
    output wire irig_output,
    
    output wire FM_output_debug,
    output wire ZTC_output_debug,
    output wire polarity_output_debug,
    output wire irig_output_debug
);

localparam  PROGRAM_ID = 16'h0200,
            VERSION_LARGE = 12'd0,
            VERSION_SMALL = 4'd0;

localparam  PERIOD1 = 20000,
            DELAY1 = 1000,
            PULSE_WIDTH1 = 2500,
            PULSE_WIDTH2 = 4000,
            PULSE_WIDTH3 = 7000,
            PULSE_WIDTH4 = 12000;           
        
wire fm_signal;
wire ztc_signal;
wire pol_signal;
wire irig_signal;

reg [31:0]  main_counter_reg, main_counter_next;
reg polarity_reg, polarity_next;
reg [31:0]  period;

PulseTrainGenerator FMPulseTrainGen
(
    .clk(clk),
    .enable(switches[3]),
    .main_counter(main_counter_reg),
    .pulse_width(PULSE_WIDTH1),
    .delay(DELAY1),
    .period(PERIOD1),
    .pulse_train(fm_signal)
);

PulseTrainGenerator ZTCPulseTrainGen
(
    .clk(clk),
    .enable(switches[2]),
    .main_counter(main_counter_reg),
    .pulse_width(PULSE_WIDTH2),
    .delay(DELAY1),
    .period(PERIOD1),
    .pulse_train(ztc_signal)
);

//PulseTrainGenerator POLPulseTrainGen
//(
//    .clk(clk),
//    .enable(switches[1]),
//    .main_counter(main_counter_reg),
//    .pulse_width(PERIOD1),
//    .period(PERIOD1),
//    .pulse_train(pol_signal)
//);

PulseTrainGenerator IRIGPulseTrainGen
(
    .clk(clk),
    .enable(switches[0]),
    .main_counter(main_counter_reg),
    .pulse_width(PULSE_WIDTH4),
    .delay(DELAY1),
    .period(PERIOD1),
    .pulse_train(irig_signal)
);

always @(posedge clk)
begin
    main_counter_reg <= main_counter_next;
    polarity_reg <= polarity_next;
end

always@*
begin
    main_counter_next = main_counter_reg;
    polarity_next = polarity_reg;
    
    if(main_counter_reg == PERIOD1)
    begin
        main_counter_next = 32'd0;       
        polarity_next = ~polarity_reg;
    end
    else
    begin
        main_counter_next = main_counter_reg + 1;
    end
end

assign pol_signal = polarity_reg && switches[1];

assign rgbs = main_counter_reg[11:0];
assign FM_output = fm_signal;
assign ZTC_output = ztc_signal;
assign polarity_output = pol_signal;
assign irig_output = irig_signal;

assign FM_output_debug = fm_signal;
assign ZTC_output_debug = ztc_signal;
assign polarity_output_debug = pol_signal;
assign irig_output_debug = irig_signal;

assign led[3] = fm_signal;
assign led[2] = ztc_signal;
assign led[1] = pol_signal;
assign led[0] = irig_signal;

endmodule
