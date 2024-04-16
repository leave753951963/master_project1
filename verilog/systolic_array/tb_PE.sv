`timescale 1ns / 1ps
`include "./PE.v"
`define W_PAT	"/home/wzc/verilog/approx_pe/dat/v2_test_pat/weight_v2_pat.dat"
`define F_PAT	"/home/wzc/verilog/approx_pe/dat/v2_test_pat/ifmap_v2_pat.dat"
`define EXACT_P_GOLD "/home/wzc/verilog/approx_pe/dat/v2_test_pat/gold_exact_P_v2_result.dat"
`define CYCLE 10
module tb_PE;

	// Inputs
	reg clk;
	reg rst;
	reg weight_en;
	reg signed[15:0]	activation_in, weight_in, partial_sum_in ;

	// Outputs
	wire signed[15:0]   reg_activation;
	wire signed[15:0]	reg_weight;
	wire signed[15:0]	reg_partial_sum;
	// Instantiate the Unit Under Test (UUT)
	PE uut (
		.clk(clk), 
		.rst(rst), 
		.activation_in(activation_in),
		.weight_in(weight_in),
		.partial_sum_in(partial_sum_in),
		.reg_activation(reg_activation),
		.reg_weight(reg_weight),
		.reg_partial_sum(reg_partial_sum), 
		.weight_en(weight_en)
	);
	reg signed[15:0] weight[3:0];
	reg signed[15:0] activation[3:0];
	reg signed[15:0] gold_pat[3:0];
	int fp_r,i,j;
	
	parameter PAT_N   = 1000000;
	reg signed  [15:0]   ifmap_mem   [0:PAT_N-1];
	reg signed [15:0]   weight_mem    [0:PAT_N-1];
	reg signed  [15:0]   exact_P_mem   [0:PAT_N-1];
	reg signed [15:0]   approx_P_mem    [0:PAT_N-1];
	reg signed  [15:0]   gold_exact_P_mem   [0:PAT_N-1];
	reg signed [15:0]   gold_approx_P_mem    [0:PAT_N-1];
	initial	$readmemb (`F_PAT, ifmap_mem);
	initial	$readmemb (`W_PAT, weight_mem);
	initial	$readmemb (`EXACT_P_GOLD, gold_exact_P_mem);
	//initial	$readmemb (`APPROX_P_GOLD, gold_approx_P_mem);
	initial begin
	for(i=0;i<10;i++)begin
		//$display("ifmap_mem[%d] = %b",i,ifmap_mem[i]);
		//$display("weight_mem[%d] = %b",i,weight_mem[i]);
		$display("gold_exact_P_mem[%d] = %d",i,gold_exact_P_mem[i]);
	end
	end
	int input_en,RECEIVE_en;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		weight_en = 0;
		RECEIVE_en =0;
		input_en=0;
		weight_in = 16'd0;
		activation_in = 16'd0;
		i=0;
		j=0;
		// Add stimulus here
		#10 rst = 1;
		#10 rst = 0;
		weight_en = 1;partial_sum_in = 16'd0;
		#10 input_en = 1;$display("--input_en = 1---");
		#(`CYCLE)RECEIVE_en =1;$display("--reg_partial_sum =%d---",reg_partial_sum);
		
		#100 $finish;
	end
	
	
	always@(negedge clk) begin
		if(weight_en == 1)begin
			
			activation_in = ifmap_mem[i];weight_in = weight_mem[i];
			i=i+1;
			if(i == 10)begin
			#(`CYCLE)
			weight_en =0;
			end
		end	
	end
reg signed[31:0] product;	
	always@(negedge clk) begin
		if(RECEIVE_en == 1)begin
			product=ifmap_mem[j]*weight_mem[j];
			if(reg_partial_sum != gold_exact_P_mem[j])begin
				$display("[%d],pat=%d,gold=%d",j,reg_partial_sum,gold_exact_P_mem[j]);
			end
			if(product[25:10] != gold_exact_P_mem[j])begin
				$display("[%d],product=%d,gold=%d",j,product[25:10],gold_exact_P_mem[j]);
			end
			
			j=j+1;
			if(j == 10)begin
			RECEIVE_en =0;
			end
			//$display("j = %d",j);
		end	
	end
	always begin
	#5 clk = ~clk;
	end
    
	always @(posedge clk) begin
    //$display("At time %t, reg_partial_sum = %d",$time,reg_partial_sum);
	end
	
	initial begin
	$fsdbDumpfile("tb_PE.fsdb");
	$fsdbDumpvars;
	$fsdbDumpMDA;
	end   
endmodule

