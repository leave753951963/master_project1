`timescale 1ns / 1ps
`include "./SA22.v"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   
// Design Name:   
// Module Name:   
// Project Name:  tb_SA22
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module tb_SA22;

    reg clk, rst;
    reg weight_en;
    reg[15:0] partial_sum_in11, partial_sum_in12;
    reg[15:0] weight_in11, weight_in12;
    reg[15:0] activation_in11, activation_in21;

    wire[15:0]reg_partial_sum21, reg_partial_sum22;
    wire[15:0]reg_weight21,reg_weight22;
    wire[15:0]reg_activation12, reg_activation22;

    SA22 u1(
        .clk(clk),
        .rst(rst), 
        .partial_sum_in11(partial_sum_in11), 
        .partial_sum_in12(partial_sum_in12), 
        .weight_in11(weight_in11), .weight_in12(weight_in12), 
        .activation_in11(activation_in11), 
        .activation_in21(activation_in21), 
        .reg_partial_sum21(reg_partial_sum21), 
        .reg_partial_sum22(reg_partial_sum22),
        .reg_weight21(reg_weight21), 
        .reg_weight22(reg_weight22),
        .reg_activation12(reg_activation12), 
        .reg_activation22(reg_activation22),
        .weight_en(weight_en)
        );

    initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
        partial_sum_in11 = 0;
        partial_sum_in12 = 0;
        weight_in11 = 0;
        weight_in12 = 0;
        activation_in11 = 0;
        activation_in21 = 0;
		// Add stimulus here
		#10 rst = 1;
		#10 rst = 0;
		#5 weight_in11 = 16'd7; weight_in12 = 16'd8; weight_en = 1;
		#10 weight_in11 = 16'd5; weight_in12 = 16'd6; 
        #10 weight_en = 0;
        #10 activation_in11 = 16'd1; activation_in21 = 16'd0;
        #10 activation_in11 = 16'd3; activation_in21 = 16'd2;
        #10 activation_in11 = 16'd0; activation_in21 = 16'd4;
		#100 $finish;
	end
	always begin
	#5 clk = ~clk;
	end

	initial begin
  	$fsdbDumpfile("SA22.fsdb");
  	$fsdbDumpvars;
  	$fsdbDumpMDA;
 	end
endmodule