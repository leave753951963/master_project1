`timescale 1ns/10ps
`include "./PE_approx_SA.v"

`define End_CYCLE  100000000000

module tb_PE_approx_SA;

  reg clk;
  reg reset;
  reg [15:0] ifmap, weight;
  reg [15:0] ipsum;
  wire[15:0] approx_psum_reg;
  wire[15:0] approx_P;

  // Instantiate the module under test
  PE_approx_SA uut (
    .clk(clk),
    .reset(reset),
    .ifmap(ifmap),
    .weight(weight),
    .ipsum(ipsum),
    .approx_psum_reg(approx_psum_reg),
    .approx_P(approx_P)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end

  // Test procedure
  initial begin
    // Initialize inputs
    reset = 1;
    #10 reset = 0; 
    #10;



    // Test case 1
    ifmap = 16'b0000001100001110;
    weight = 16'b0101011010101100;
    ipsum = 16'd0;
    #50;

    // Test case 2
    ifmap = 16'b1111000110000101;
    weight = 16'b0001101100100100;
    ipsum = 16'h0000;
    #50;
    // Test case 3
    ifmap = 16'b1111111100011001;
    weight = 16'b0011000011000110;
    ipsum = 16'h0000;
    #50;
    // Add more test cases as needed

    // Finish simulation
    #100;
    $finish;
  end
	initial begin
  	$fsdbDumpfile("PE_approx_SA.fsdb");
  	$fsdbDumpvars;
  	$fsdbDumpMDA;
 	end
    
endmodule