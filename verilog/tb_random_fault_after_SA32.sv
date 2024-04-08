
`timescale 1ns / 1ps
`include "./systolic_array/SA32_random_fault_protected.v"
`define CYCLE 		10.0
`define End_CYCLE  	1000000
`define IN_FEATUREMAP	""
`define WEIGHT	"/home/wzc/lenet/LeNet-5-MNIST-PyTorch/weight/weight0986.dat"
`define INPUT	"/home/wzc/lenet/LeNet-5-MNIST-PyTorch/MNIST_test.csv"
`define FAULT_INFO	"./fault_inject_info.dat"
//`define INPUT	"/home/wzc/verilog/input_test.dat"
module tb_SA32();
  reg weight_en;
  reg clk,rst;
  reg signed[15:0]   in_weight[0:31];
  reg signed[15:0]   in_psum[0:31];
  reg signed[15:0]   in_activation[0:31];
  wire signed[15:0]   reg_psum[0:31];
  wire signed[15:0]	 spare_reg_psum[0:31];
  SA32   cut1(.rst(rst), .clk(clk), .weight_en(weight_en), .in_weight_0(in_weight[0]), .in_psum_0(in_psum[0]), .in_weight_1(in_weight[1]), .in_psum_1(in_psum[1]), .in_weight_2(in_weight[2]), .in_psum_2(in_psum[2]), .in_weight_3(in_weight[3]), .in_psum_3(in_psum[3]), .in_weight_4(in_weight[4]), .in_psum_4(in_psum[4]), .in_weight_5(in_weight[5]), .in_psum_5(in_psum[5]), .in_weight_6(in_weight[6]), .in_psum_6(in_psum[6]), .in_weight_7(in_weight[7]), .in_psum_7(in_psum[7]), .in_weight_8(in_weight[8]), .in_psum_8(in_psum[8]), .in_weight_9(in_weight[9]), .in_psum_9(in_psum[9]), .in_weight_10(in_weight[10]), .in_psum_10(in_psum[10]), .in_weight_11(in_weight[11]), .in_psum_11(in_psum[11]), .in_weight_12(in_weight[12]), .in_psum_12(in_psum[12]), .in_weight_13(in_weight[13]), .in_psum_13(in_psum[13]), .in_weight_14(in_weight[14]), .in_psum_14(in_psum[14]), .in_weight_15(in_weight[15]), .in_psum_15(in_psum[15]), .in_weight_16(in_weight[16]), .in_psum_16(in_psum[16]), .in_weight_17(in_weight[17]), .in_psum_17(in_psum[17]), .in_weight_18(in_weight[18]), .in_psum_18(in_psum[18]), .in_weight_19(in_weight[19]), .in_psum_19(in_psum[19]), .in_weight_20(in_weight[20]), .in_psum_20(in_psum[20]), .in_weight_21(in_weight[21]), .in_psum_21(in_psum[21]), .in_weight_22(in_weight[22]), .in_psum_22(in_psum[22]), .in_weight_23(in_weight[23]), .in_psum_23(in_psum[23]), .in_weight_24(in_weight[24]), .in_psum_24(in_psum[24]), .in_weight_25(in_weight[25]), .in_psum_25(in_psum[25]), .in_weight_26(in_weight[26]), .in_psum_26(in_psum[26]), .in_weight_27(in_weight[27]), .in_psum_27(in_psum[27]), .in_weight_28(in_weight[28]), .in_psum_28(in_psum[28]), .in_weight_29(in_weight[29]), .in_psum_29(in_psum[29]), .in_weight_30(in_weight[30]), .in_psum_30(in_psum[30]), .in_weight_31(in_weight[31]), .in_psum_31(in_psum[31]), .in_activation_0(in_activation[0]), .in_activation_1(in_activation[1]), .in_activation_2(in_activation[2]), .in_activation_3(in_activation[3]), .in_activation_4(in_activation[4]), .in_activation_5(in_activation[5]), .in_activation_6(in_activation[6]), .in_activation_7(in_activation[7]), .in_activation_8(in_activation[8]), .in_activation_9(in_activation[9]), .in_activation_10(in_activation[10]), .in_activation_11(in_activation[11]), .in_activation_12(in_activation[12]), .in_activation_13(in_activation[13]), .in_activation_14(in_activation[14]), .in_activation_15(in_activation[15]), .in_activation_16(in_activation[16]), .in_activation_17(in_activation[17]), .in_activation_18(in_activation[18]), .in_activation_19(in_activation[19]), .in_activation_20(in_activation[20]), .in_activation_21(in_activation[21]), .in_activation_22(in_activation[22]), .in_activation_23(in_activation[23]), .in_activation_24(in_activation[24]), .in_activation_25(in_activation[25]), .in_activation_26(in_activation[26]), .in_activation_27(in_activation[27]), .in_activation_28(in_activation[28]), .in_activation_29(in_activation[29]), .in_activation_30(in_activation[30]), .in_activation_31(in_activation[31]), .out_psum_0(reg_psum[0]), .out_psum_1(reg_psum[1]), .out_psum_2(reg_psum[2]), .out_psum_3(reg_psum[3]), .out_psum_4(reg_psum[4]), .out_psum_5(reg_psum[5]), .out_psum_6(reg_psum[6]), .out_psum_7(reg_psum[7]), .out_psum_8(reg_psum[8]), .out_psum_9(reg_psum[9]), .out_psum_10(reg_psum[10]), .out_psum_11(reg_psum[11]), .out_psum_12(reg_psum[12]), .out_psum_13(reg_psum[13]), .out_psum_14(reg_psum[14]), .out_psum_15(reg_psum[15]), .out_psum_16(reg_psum[16]), .out_psum_17(reg_psum[17]), .out_psum_18(reg_psum[18]), .out_psum_19(reg_psum[19]), .out_psum_20(reg_psum[20]), .out_psum_21(reg_psum[21]), .out_psum_22(reg_psum[22]), .out_psum_23(reg_psum[23]), .out_psum_24(reg_psum[24]), .out_psum_25(reg_psum[25]), .out_psum_26(reg_psum[26]), .out_psum_27(reg_psum[27]), .out_psum_28(reg_psum[28]), .out_psum_29(reg_psum[29]), .out_psum_30(reg_psum[30]), .out_psum_31(reg_psum[31]), .spare_out_psum_0(spare_reg_psum[0]), .spare_out_psum_1(spare_reg_psum[1]), .spare_out_psum_2(spare_reg_psum[2]), .spare_out_psum_3(spare_reg_psum[3]), .spare_out_psum_4(spare_reg_psum[4]), .spare_out_psum_5(spare_reg_psum[5]), .spare_out_psum_6(spare_reg_psum[6]), .spare_out_psum_7(spare_reg_psum[7]), .spare_out_psum_8(spare_reg_psum[8]), .spare_out_psum_9(spare_reg_psum[9]), .spare_out_psum_10(spare_reg_psum[10]), .spare_out_psum_11(spare_reg_psum[11]), .spare_out_psum_12(spare_reg_psum[12]), .spare_out_psum_13(spare_reg_psum[13]), .spare_out_psum_14(spare_reg_psum[14]), .spare_out_psum_15(spare_reg_psum[15]), .spare_out_psum_16(spare_reg_psum[16]), .spare_out_psum_17(spare_reg_psum[17]), .spare_out_psum_18(spare_reg_psum[18]), .spare_out_psum_19(spare_reg_psum[19]), .spare_out_psum_20(spare_reg_psum[20]), .spare_out_psum_21(spare_reg_psum[21]), .spare_out_psum_22(spare_reg_psum[22]), .spare_out_psum_23(spare_reg_psum[23]), .spare_out_psum_24(spare_reg_psum[24]), .spare_out_psum_25(spare_reg_psum[25]), .spare_out_psum_26(spare_reg_psum[26]), .spare_out_psum_27(spare_reg_psum[27]), .spare_out_psum_28(spare_reg_psum[28]), .spare_out_psum_29(spare_reg_psum[29]), .spare_out_psum_30(spare_reg_psum[30]), .spare_out_psum_31(spare_reg_psum[31]));
integer	count;
integer fp_r,i,j;
int total_predic_num,acc_num,acc;

initial begin
clk = 0;
rst = 0;
weight_en = 0;
in_weight[0] = 0;
in_psum[0] = 0;
in_weight[1] = 0;
in_psum[1] = 0;
in_weight[2] = 0;
in_psum[2] = 0;
in_weight[3] = 0;
in_psum[3] = 0;
in_weight[4] = 0;
in_psum[4] = 0;
in_weight[5] = 0;
in_psum[5] = 0;
in_weight[6] = 0;
in_psum[6] = 0;
in_weight[7] = 0;
in_psum[7] = 0;
in_weight[8] = 0;
in_psum[8] = 0;
in_weight[9] = 0;
in_psum[9] = 0;
in_weight[10] = 0;
in_psum[10] = 0;
in_weight[11] = 0;
in_psum[11] = 0;
in_weight[12] = 0;
in_psum[12] = 0;
in_weight[13] = 0;
in_psum[13] = 0;
in_weight[14] = 0;
in_psum[14] = 0;
in_weight[15] = 0;
in_psum[15] = 0;
in_weight[16] = 0;
in_psum[16] = 0;
in_weight[17] = 0;
in_psum[17] = 0;
in_weight[18] = 0;
in_psum[18] = 0;
in_weight[19] = 0;
in_psum[19] = 0;
in_weight[20] = 0;
in_psum[20] = 0;
in_weight[21] = 0;
in_psum[21] = 0;
in_weight[22] = 0;
in_psum[22] = 0;
in_weight[23] = 0;
in_psum[23] = 0;
in_weight[24] = 0;
in_psum[24] = 0;
in_weight[25] = 0;
in_psum[25] = 0;
in_weight[26] = 0;
in_psum[26] = 0;
in_weight[27] = 0;
in_psum[27] = 0;
in_weight[28] = 0;
in_psum[28] = 0;
in_weight[29] = 0;
in_psum[29] = 0;
in_weight[30] = 0;
in_psum[30] = 0;
in_weight[31] = 0;
in_psum[31] = 0;
in_activation[0] = 0;
in_activation[1] = 0;
in_activation[2] = 0;
in_activation[3] = 0;
in_activation[4] = 0;
in_activation[5] = 0;
in_activation[6] = 0;
in_activation[7] = 0;
in_activation[8] = 0;
in_activation[9] = 0;
in_activation[10] = 0;
in_activation[11] = 0;
in_activation[12] = 0;
in_activation[13] = 0;
in_activation[14] = 0;
in_activation[15] = 0;
in_activation[16] = 0;
in_activation[17] = 0;
in_activation[18] = 0;
in_activation[19] = 0;
in_activation[20] = 0;
in_activation[21] = 0;
in_activation[22] = 0;
in_activation[23] = 0;
in_activation[24] = 0;
in_activation[25] = 0;
in_activation[26] = 0;
in_activation[27] = 0;
in_activation[28] = 0;
in_activation[29] = 0;
in_activation[30] = 0;
in_activation[31] = 0;

$display("----------------------");
$display("-- Simulation Start --");
$display("----------------------");

end
reg [3:0] Label[0:9999];
reg [3:0] Label_now;
reg signed[15:0]Input_mem[0:(10000*28*28)-1];
reg signed[15:0] Input_feature[27:0][27:0];	
reg signed[15:0] input_conv1[599:0][24:0];
reg signed[15:0] conv1_kernel[5:0][24:0];//5x5矩陣有6個,一個矩陣攤成一raw
reg signed[15:0] conv1_output[144:0][23:0];//6個24*24的矩陣
reg	signed[15:0] bias_conv1[0:5];
reg signed[15:0] maxpool1[71:0][11:0];//12*12有六個

reg signed[15:0] input_conv2[527:0][24:0];
reg	signed[15:0] conv2_kernel1[95:0][24:0];//5x5矩陣有6個,共16組，一個矩陣攤成一raw
reg signed[15:0] conv2_output[127:0][7:0];//8*8矩陣有16個
reg	signed[15:0] bias_conv2[0:15];
reg signed[15:0] maxpool2[63:0][3:0];
reg signed[15:0] FC1_input[255:0][31:0];
reg signed[15:0] FC1[119:0][255:0];//256*120 120包維度為256*1的矩陣
reg signed[15:0] FC1_output[119:0];
reg signed[15:0] FC2_input[127:0][31:0];
reg signed[15:0] FC2[83:0][127:0];//120一包 共84個output 右邊再加8欄0
reg signed[15:0] FC2_output[83:0];
reg signed[15:0] FC3_input[95:0][31:0];
reg signed[15:0] FC3[9:0][95:0];//84一包 運算出一個output,共10組 右邊再加12欄0
reg signed[15:0] FC3_output[9:0];
reg signed[15:0] bias_FC1[0:119];
reg signed[15:0] bias_FC2[0:83];
reg signed[15:0] bias_FC3[0:9];
	

int count_weight_in;	
string output_file1;
string output_file2;
//==================read input=======================
initial begin 


fp_r=$fopen(`INPUT,"r");
if (fp_r == 0)begin
    $display ("INPUT pattern handle null");
       $finish;
   end
   for(i=0;i<10000;i++)begin
		$fscanf(fp_r,"%b",Label[i]); 
		//$display("Label[%d] = %d",i,Label[i]);  
		for(j=0;j<28*28;j++)begin
			$fscanf(fp_r,"%b",Input_mem[j+(i*28*28)]);
			//$display("Input_mem[%d] = %d",j+(i*28*28),Input_mem[j+(i*28*28)]);
		end
		//for (i=0;i<28;i++) begin//28*28 input
		//	for(j=0;j<28;j++)begin
		//		$fscanf(fp_r,"%b",Input_feature[i][j]);
		//		//$display("Input_feature[%d][%d]==%d",i,j,Input_feature[i][j]);
		//	end
		//end	    
	end	
$fclose(fp_r);	


//==================read weight=======================
fp_r=$fopen(`WEIGHT,"r");
if (fp_r == 0)begin
    $display ("WEIGHT pattern handle null");
       $finish;
   end
$display("open the file successfully");
//while(!$feof(fp_r))
for (i=0;i<6;i++) begin//conv1
	for(j=0;j<25;j++)begin
		$fscanf(fp_r,"%b",conv1_kernel[i][j]);
		//$display("[%d][%d]==%b",i,j,conv1_kernel[i][j]);
	end
end	
for (i=0;i<6;i++) begin//bias conv1
	$fscanf(fp_r,"%b",bias_conv1[i]);
	//$display("[%d]==%b",i,bias_conv1[i]);
end	
 
for (i=0;i<96;i++) begin//conv2
	for(j=0;j<25;j++)begin
	$fscanf(fp_r,"%b",conv2_kernel1[i][j]);
	//$display("[%d][%d]==%d",i,j,conv2_kernel1[i][j]);
	end
end		
for (i=0;i<16;i++) begin//bias conv2
	$fscanf(fp_r,"%b",bias_conv2[i]);
	//$display("[%d]==%d",i,bias_conv2[i]);
end	

for (i=0;i<120;i++) begin//FC1
	for(j=0;j<256;j++)begin
	$fscanf(fp_r,"%b",FC1[i][j]);
	//$display("[%d][%d]==%b",i,j,FC1[i][j]);
	end
end		
for (i=0;i<120;i++) begin//bias_FC1
	$fscanf(fp_r,"%b",bias_FC1[i]);
	//$display("[%d]==%b",i,bias_FC1[i]);
end	

for (i=0;i<84;i++) begin//FC2
	for(j=0;j<128;j++)begin
		if(j>119)begin
			FC2[i][j] = 0;end
		else begin
			$fscanf(fp_r,"%b",FC2[i][j]);
		end
	end	
end		
for (i=0;i<84;i++) begin//bias_FC2
	$fscanf(fp_r,"%b",bias_FC2[i]);
	//$display("[%d]==%b",i,bias_FC2[i]);
end	

for (i=0;i<10;i++) begin//FC3
	for(j=0;j<96;j++)begin
		if(j>83)begin
			FC3[i][j] = 16'd0;end
		else begin
			$fscanf(fp_r,"%b",FC3[i][j]);
		end 
		//$display("FC3[%d][%d]==%b",i,j,FC3[i][j]);
	end
end		
for (i=0;i<10;i++) begin//bias_FC3
	$fscanf(fp_r,"%b",bias_FC3[i]);
	//$display("[%d]==%b",i,bias_FC3[i]);
end	
$fclose(fp_r);		

end
 

//==========================================
int START_predict;
int conv1_en,conv2_en,FC1_weight_en,FC2_weight_en,FC3_weight_en;
int op_conv1_en,op_conv2_en,op_FC1_en,op_FC2_en,op_FC3_en;
int RECEIVE_conv1_out,RECEIVE_conv2_out,RECEIVE_FC1_out,RECEIVE_FC2_out,RECEIVE_FC3_out;
int k,r,c,test_num;
int is_it_acc;
initial begin
	total_predic_num = 0;
	acc_num = 0;
	for(test_num=0;test_num<100;test_num++)begin
	
		#(`CYCLE)
		@(negedge clk);   rst = 1'b1;
		#(`CYCLE*2);
		@(negedge clk);    rst = 1'b0;
		Label_now = Label[502+test_num]; 
		for (i=0;i<28;i++) begin//28*28 input
			for(j=0;j<28;j++)begin
				Input_feature[i][j] = Input_mem[((502+test_num)*28*28)+(i*28)+j];
				//$display("Input_feature[%d][%d]==%d",i,j,Input_feature[i][j]);
			end
		end	
		initialize_input_conv1;
		#`CYCLE weight_en = 1;conv1_en =1;
		wait(conv1_en == 0); op_conv1_en = 1;
		#(`CYCLE*(33));RECEIVE_conv1_out = 1;wait(RECEIVE_conv1_out ==0);//operate conv1
		
		repeat(6)begin
			weight_en = 1;conv2_en = 1;//weight of conv2
			wait(conv2_en == 0);op_conv2_en = 1;
			#(`CYCLE*(33));RECEIVE_conv2_out = 1;wait(RECEIVE_conv2_out ==0);//operate round1 of conv2 
			//$display("hii=======[%d]",i);
		end
		
		
		repeat(32)begin
			weight_en = 1;FC1_weight_en = 1;
			wait(FC1_weight_en == 0); op_FC1_en = 1;
			#(`CYCLE*33);RECEIVE_FC1_out = 1;wait(RECEIVE_FC1_out == 0);
		end
		
		repeat(12)begin
			weight_en = 1;FC2_weight_en = 1;
			wait(FC2_weight_en == 0); op_FC2_en = 1;
			#(`CYCLE*33);RECEIVE_FC2_out = 1;wait(RECEIVE_FC2_out == 0);
		end
		
		repeat(3)begin
			weight_en = 1;FC3_weight_en = 1;
			wait(FC3_weight_en == 0); op_FC3_en = 1;
			#(`CYCLE*33);RECEIVE_FC3_out = 1;wait(RECEIVE_FC3_out == 0);
		end
		
		IS_IT_ACC;
		total_predic_num = total_predic_num+1;
		$display("---%dth img---",total_predic_num);
		//acc_num = acc_num+is_it_acc;
		#(`CYCLE*5);	
	end	
	acc = acc_num; 
	$display("output file = %s %s",output_file1,output_file2);
	
	$display("acc = %d",acc);
	$display("total_predic_num = %d",total_predic_num);
	$fwrite(file_acc, "%d\n",acc);
	#10000 $finish;	
end
//==========bias error compare==============

int write_content[0:31];
int file_handle0,file_handle1,file_handle2,file_handle3,file_handle4,file_handle5,file_handle6,file_handle7,file_handle8,file_handle9
,file_handle10,file_handle11,file_handle12,file_handle13,file_handle14,file_handle15,file_handle16,file_handle17,file_handle18,file_handle19
,file_handle20,file_handle21,file_handle22,file_handle23,file_handle24,file_handle25,file_handle26,file_handle27,file_handle28,file_handle29
,file_handle30,file_handle31,file_acc;
int write_condition;
always@(negedge clk)begin
	for(i=0;i<32;i++)begin
		write_content[i] = (reg_psum[i]*100)/(spare_reg_psum[i]);
	end	
	write_condition = (total_predic_num ==0)?1:0;
end
initial begin
  file_acc = $fopen("acc_fault_after.txt", "a");
  file_handle0 = $fopen("output0.txt", "w");
  file_handle1 = $fopen("output1.txt", "w");
  file_handle2 = $fopen("output2.txt", "w");
  file_handle3 = $fopen("output3.txt", "w");
  file_handle4 = $fopen("output4.txt", "w");
  file_handle5 = $fopen("output5.txt", "w");
  file_handle6 = $fopen("output6.txt", "w");
  file_handle7 = $fopen("output7.txt", "w");
  file_handle8 = $fopen("output8.txt", "w");
  file_handle9 = $fopen("output9.txt", "w");
  file_handle10 = $fopen("output10.txt", "w");
  file_handle11 = $fopen("output11.txt", "w");
  file_handle12 = $fopen("output12.txt", "w");
  file_handle13 = $fopen("output13.txt", "w");
  file_handle14 = $fopen("output14.txt", "w");
  file_handle15 = $fopen("output15.txt", "w");
  file_handle16 = $fopen("output16.txt", "w");
  file_handle17 = $fopen("output17.txt", "w");
  file_handle18 = $fopen("output18.txt", "w");
  file_handle19 = $fopen("output19.txt", "w");
  file_handle20 = $fopen("output20.txt", "w");
  file_handle21 = $fopen("output21.txt", "w");
  file_handle22 = $fopen("output22.txt", "w");
  file_handle23 = $fopen("output23.txt", "w");
  file_handle24 = $fopen("output24.txt", "w");
  file_handle25 = $fopen("output25.txt", "w");
  file_handle26 = $fopen("output26.txt", "w");
  file_handle27 = $fopen("output27.txt", "w");
  file_handle28 = $fopen("output28.txt", "w");
  file_handle29 = $fopen("output29.txt", "w");
  file_handle30 = $fopen("output30.txt", "w");
  file_handle31 = $fopen("output31.txt", "w");

end
//==========img2col=========================


task initialize_input_conv1; 

for(r=0;r<600;r++)begin//先把整個矩陣歸0
	for(c=0;c<25;c++)begin
		input_conv1[r][c] = 0;
		
		//$display("input_conv1[%d][%d]",r,c);			
	end
end
	for(r=0;r<(28-4);r++)begin//轉好的矩陣input_conv1(600*25)
		for(c=0;c<(28-4);c++)begin
			for(i=0;i<5;i++)begin
				for(j=0;j<5;j++)begin
					input_conv1[(5*i)+j+(24*r)+c][(5*i)+j] = Input_feature[i+r][j+c];
					//$display("input_conv1[%d][%d] = %d",(5*i)+j+(24*r)+c,(5*i)+j,Input_feature[i+r][j+c]);
				end
			end
		end
	end	
for(r=0;r<200;r++)begin//先把整個矩陣歸0
	for(c=0;c<25;c++)begin
		//$display("input_conv1[%d][%d] = %d",r,c,input_conv1[r][c]);			
	end
end
endtask
//================mapping conv1 input======================
int input_conv1_cnt;

always@(negedge clk) begin
	if(rst ==1)begin
	input_conv1_cnt = 0;end
	else if(op_conv1_en == 1)begin//conv1運算 輸入input
			for(i=0;i<32;i++)begin//
				if(i<25)begin//(activation[0~24])
				in_activation[i] =  input_conv1[input_conv1_cnt][i];
				//$display("in_activation[%d] =%d",i,input_conv1[input_conv1_cnt][i]);
				end
				else begin
				in_activation[i] =  0;end
			end
			input_conv1_cnt = input_conv1_cnt+1;
			if(input_conv1_cnt == 600)begin
				#(`CYCLE)
				op_conv1_en = 0;
			end	
	end
end

//===============mapping weight =======================

int	conv1_count;
always @(negedge clk ) begin//conv1 weight 放入 in_weight
	if(rst == 1)begin
		conv1_count = 0;end
	else if(conv1_en == 1) begin
			if(conv1_count == 0)begin
				$display("----------conv1_weight is being transmitted----------");end
			for (i=0;i<6;i++) begin
				in_weight[i] = conv1_kernel[i][24-(conv1_count)];
				//$display("in_weight[%d] = conv1_kernel[%d][%d]",i,i,24-(conv1_count));
			end
			conv1_count = conv1_count+1;
			//$display("conv1_count == %d",conv1_count);
			if(conv1_count ==25)begin
				#(`CYCLE)
				conv1_en = 0;
				conv1_count = 0;
				weight_en = 0; end	
	end
end	
//========CONV2
int	conv2_count;
int conv2_times;
int loop;
always @(negedge clk ) begin//conv2
	if(rst == 1)begin
		conv2_count = 0;
		conv2_times = 0;
		loop = 0;end
	else if(conv2_en == 1)begin
	
			if(conv2_count == 0)begin
			$display("----------conv2_weight is being transmitted----------");
			end
				
			for (i=0;i<16;i++) begin 
				in_weight[i] = conv2_kernel1[(i*6)+conv2_times][24-conv2_count];
				//$display("in_weight[%d] = conv2_kernel[%d][%d]",i,(i*6)+conv2_times,24-conv2_count);
			end
			conv2_count = conv2_count+1; 
			if(conv2_count ==25)begin
				#(`CYCLE)
				conv2_times = conv2_times+1;
				//$display("-------conv2_times = %d--------------",conv2_times);
				conv2_count = 0;
				conv2_en = 0;
				weight_en = 0;
			end
	end	
end
//=======FC1===========
int FC1_count ;
int FC1_times ;
int FC1_round;
always @(negedge clk ) begin
	if(rst == 1)begin
		FC1_count = 0;
		FC1_times = 0;
	end
	else if(FC1_weight_en == 1)begin
		
			if(FC1_count == 0)begin
			$display("----------FC1_weight is being transmitted----------");
			end
			if(FC1_times<3)begin
				for(i=0;i<32;i++)begin
					in_weight[i] = FC1[(FC1_times*32)+i][((FC1_round%8)*32)+31-FC1_count];//由後往前放
				end
			end
			else if(FC1_times==3)begin
				for(i=0;i<24;i++)begin
					in_weight[i] = FC1[(FC1_times*32)+i][((FC1_round%8)*32)+31-FC1_count];
					//$display("FC1[%d][%d]",((FC1_times*32)+i),((FC1_round%8)*32)+31-FC1_count);
				end//由後往前放
				
			end
			FC1_count = FC1_count+1;
			//$display("----------FC1_count = %d----------",FC1_count);
			if(FC1_count%32 == 0)begin
				#(`CYCLE)
				FC1_weight_en = 0;
				FC1_count = 0;
				weight_en = 0;
				//$display("----------FC1_weight_en = 0----------");
				
			end
	end
end	
//=======FC2===========
int FC2_count ;
int FC2_times ;
int FC2_round;
always @(negedge clk ) begin
	if(rst == 1)begin
		FC2_count = 0;
		FC2_times = 0;
	end
	else if(FC2_weight_en == 1)begin
		
			if(FC2_count == 0)begin
			$display("----------FC2_weight is being transmitted----------");
			end
			if(FC2_round<8)begin
				for(i=0;i<32;i++)begin
					
					in_weight[i] = FC2[(FC2_times*32)+i][((FC2_round%4)*32)+31-FC2_count];//由後往前放
					//$display("in_weight[%d] = FC2[%d][%d]",i,(FC2_times*32)+i,((FC2_round%4)*32)+31-FC2_count);
					
				end
			end
			else begin
				for(i=0;i<20;i++)begin
					in_weight[i] = FC2[(FC2_times*32)+i][((FC2_round%4)*32)+31-FC2_count];//由後往前放
					//$display("in_weight[%d] = FC2[%d][%d]",i,(FC2_times*32)+i,((FC2_round%4)*32)+31-FC2_count);
				end
			end
			FC2_count = FC2_count+1;
			////$display("----------FC2_count = %d----------",FC2_count);
			if(FC2_count%32 == 0)begin
				#(`CYCLE)
				FC2_weight_en = 0;
				FC2_count = 0;
				weight_en = 0;
				//$display("----------FC1_weight_en = 0----------")
				
			end
	end
end	
//==========FC3============
int FC3_count ;
int FC3_times ;
int FC3_round;
always @(negedge clk ) begin
	if(rst == 1)begin
		FC3_count = 0;
		FC3_times = 0;
	end
	else if(FC3_weight_en)begin
		
			if(FC3_count == 0)begin
			$display("----------FC3_weight is being transmitted----------");
			end
			
				for(i=0;i<10;i++)begin//weight0~9一起放
					in_weight[i] = FC3[i][((FC3_round)*32)+31-FC3_count];//由後往前放
					//$display("in_weight[%d] = %d",i,FC3[i][((FC3_round%4)*32)+31-FC3_count]);
					end
			
			
			FC3_count = FC3_count+1;
			////$display("----------FC2_count = %d----------",FC2_count);
			if(FC3_count%32 == 0)begin
				#(`CYCLE)
				FC3_weight_en = 0;
				FC3_count = 0;
				weight_en = 0;
				//$display("----------FC1_weight_en = 0----------")
			end
	end
end	
//===================存取conv1 output並做bias relu maxpooling1=====================
int op_out_cnt;
reg signed[15:0] temp;

reg signed[31:0]product;
reg signed[15:0] sim_conv1_output[144:0][23:0];//6個24*24的矩陣
reg signed[15:0] sim_maxpool1[71:0][11:0];//12*12有六個
reg signed [25:10] truncated_number;
always @(negedge clk ) begin//存取conv1 output(24*24)
	if(rst == 1)begin 
		op_out_cnt = 0;end
	else if(RECEIVE_conv1_out == 1)begin
		for(i=0;i<6;i++)begin
			if(op_out_cnt>=i && op_out_cnt<(24*24+i))begin
				conv1_output[((op_out_cnt-i)/24)+(24*i)][(op_out_cnt-i)%24] = reg_psum[i];
				//-------
				
				if(write_condition == 1)begin
					if(i == 0)begin
					$fwrite(file_handle0, "%d\n",write_content[i]);end
					//$display("reg_psum[%d] = %d,spare_reg_psum[%d] = %d",i,reg_psum[i],i,spare_reg_psum[i])	;end
					if(i == 1)begin
					$fwrite(file_handle1, "%d\n",write_content[i]);end
					if(i == 2)begin
					$fwrite(file_handle2, "%d\n",write_content[i]);end
					if(i == 3)begin
					$fwrite(file_handle3, "%d\n",write_content[i]);end
					if(i == 4)begin
					$fwrite(file_handle4, "%d\n",write_content[i]);end
					if(i == 5)begin
					$fwrite(file_handle5, "%d\n",write_content[i]);end
				end
				//$display("reg_psum[%d] = %d,spare_reg_psum[%d] = %d",i,reg_psum[i],i,spare_reg_psum[i])	;
				//$display("golden_reg_psum[%d][%d] = %d",((op_out_cnt-i)/24)+(24*i),(op_out_cnt-i)%24,write_content);
					
				
			end
		end
		op_out_cnt = op_out_cnt+1;
		if(op_out_cnt == 24*24+5)begin
			#(`CYCLE)
			RECEIVE_conv1_out = 0; 
			op_out_cnt = 0;
			//--------------sim---------------//conv1比對
			for(i=0;i<144;i++)begin
				for(j=0;j<24;j++)begin
				sim_conv1_output[i][j] = 16'd0;
				end
			end	
			for(k=0;k<6;k++)begin//6kernel
				for(r=0;r<24;r++)begin
					for(c=0;c<24;c++)begin
						product = 32'd0;
						for(i=0;i<5;i++)begin
							for(j=0;j<5;j++)begin
								product = Input_feature[r+i][c+j]*conv1_kernel[k][(5*i)+j];//+product;
								truncated_number = product[25:10];
								sim_conv1_output[(k*24)+r][c] = sim_conv1_output[(k*24)+r][c]+truncated_number;
							end
						end
					end
				end
			end
			//----print---
			for(i=0;i<144;i++)begin
				for(j=0;j<24;j++)begin
					//$display("conv1_output[%d][%d] = %d",i,j,conv1_output[i][j]);
					//$display("sim_conv1_output[%d][%d] = %d",i,j,sim_conv1_output[i][j]);
				end
			end	
			//--------------------------------
			for(i=0;i<144;i++)begin//bias,ReLu
				for(j=0;j<24;j++)begin
					
					//if (conv1_output[i][j] != sim_conv1_output[i][j])begin
					//	$display("conv1_output[%d][%d] is wrong!,data = %d",i,j,conv1_output[i][j]);
					//end
					conv1_output[i][j] = conv1_output[i][j]+ bias_conv1[i/24];
					//$display("conv1_output[%d][%d] = %d",i,j,conv1_output[i][j]);
					
					if(conv1_output[i][j] <0)begin
						//$display("conv1_output[%d][%d] = %d",i,j,conv1_output[i][j]);
						conv1_output[i][j] = 0;	
					end	
					//$display("conv1_output[%d][%d] = %d",i,j,conv1_output[i][j]);	
				end
			end
			//----sim-----
			for(i=0;i<144;i++)begin//bias,ReLu
				for(j=0;j<24;j++)begin
					
					sim_conv1_output[i][j] = sim_conv1_output[i][j]+ bias_conv1[i/24];
					//$display("sim_conv1_output[%d][%d] = %d",i,j,sim_conv1_output[i][j]);
					if(sim_conv1_output[i][j] <0)begin
						sim_conv1_output[i][j] = 0;	
					end		
				end
			end
			//------------
			for(i=0;i<72;i++)begin//max pooling out(12*12)
				for(j=0;j<12;j++)begin
					temp = 16'd0;
					temp = conv1_output[(i*2)][(j*2)];
					for(r=0;r<2;r++)begin
						for(c=0;c<2;c++)begin
							if(r ==0 && c == 0)begin
							//$display("temp = %d",temp);
							end
							if(conv1_output[(i*2)+r][(j*2)+c]>temp)begin
								temp = conv1_output[(i*2)+r][(j*2)+c];
								//$display("temp = %d",temp);
							end
						end
					end
					maxpool1[i][j]= temp;
					//$display("maxpool1[%d][%d] = %d",i,j,maxpool1[i][j]);
				end
			end	
			//-------sim---------------
			for(i=0;i<72;i++)begin//max pooling out(12*12)
				for(j=0;j<12;j++)begin
					temp = 16'd0;
					temp = sim_conv1_output[(i*2)][(j*2)];
					for(r=0;r<2;r++)begin
						for(c=0;c<2;c++)begin
							if(r ==0 && c == 0)begin
							end
							if(sim_conv1_output[(i*2)+r][(j*2)+c]>temp)begin
								temp = sim_conv1_output[(i*2)+r][(j*2)+c];
							end
						end
					end
					sim_maxpool1[i][j]= temp;
					//if(sim_maxpool1[i][j] != maxpool1[i][j])begin
					//	$display("maxpool1[%d][%d] is wrong,data = %d",i,j,maxpool1[i][j]);
					//end
				end
			end
			
			
			//================img2col===================	
			
			for(r=0;r<528;r++)begin//先把整個矩陣歸0 ((24+64)*6)
				for(c=0;c<25;c++)begin
					input_conv2[r][c] = 0;
					
					//$display("input_conv2[%d][%d]",r,c);			
				end
			end
				for(k=0;k<6;k++)begin
					for(r=0;r<(12-4);r++)begin//轉好的矩陣input_conv2(528*25)
						for(c=0;c<(12-4);c++)begin
							for(i=0;i<5;i++)begin
								for(j=0;j<5;j++)begin
									input_conv2[(88*k)+(5*i)+j+(8*r)+c][(5*i)+j] = maxpool1[(12*k)+i+r][j+c];
									//$display("input_conv2[%d][%d] = %d",(88*k)+(5*i)+j+(8*r)+c,(5*i)+j,maxpool1[(12*k)+i+r][j+c]);
								end
							end
						end
					end	
				end
			//==========================================
			for(i=0;i<528;i++)begin
				for(j=0;j<25;j++)begin
					//$display("input_conv2[%d][%d] = %d",i,j,input_conv2[i][j]);
				end
			end
		end
	end	
end

//========================mapping conv2 input===========================
int input_conv2_cnt;
always@(negedge clk) begin
	if(rst ==1)begin
	input_conv2_cnt = 0;end
	else if(op_conv2_en == 1)begin//conv1運算 輸入input
			for(i=0;i<32;i++)begin
				if(i<25)begin
					in_activation[i] =  input_conv2[input_conv2_cnt][i];
				end//$display("in_activation[%d] =%d",i,input_conv1[input_conv1_cnt][i]);
				else begin
					in_activation[i] = 0;
				end
			end
			input_conv2_cnt = input_conv2_cnt+1;
			if(input_conv2_cnt%88 == 0)begin
				#(`CYCLE)
				op_conv2_en = 0;
			end	
	end
end
//=======================存取conv2 output並做bias relu=================
int num_out;
reg signed[15:0]sim_conv2_output[127:0][7:0];
reg signed[15:0]sim_maxpool2[63:0][3:0];
always @(negedge clk ) begin//存取conv1 output(24*24)
	if(rst == 1)begin
		op_out_cnt = 0;end
	else if(RECEIVE_conv2_out == 1)begin
		
		if(op_out_cnt == 0 && conv2_times == 1)begin//初始conv2_output先歸0
			for(i=0;i<128;i++)begin
				for(j=0;j<8;j++)begin
					conv2_output[i][j] = 16'd0;
				end
			end
		end
		
		for(i=0;i<16;i++)begin
			if(op_out_cnt>=i && op_out_cnt<(8*8+i))begin
				conv2_output[((op_out_cnt-i)/8)+(8*i)][(op_out_cnt-i)%8] = 
				conv2_output[((op_out_cnt-i)/8)+(8*i)][(op_out_cnt-i)%8] + reg_psum[i];
				
				if(write_condition == 1)begin
					if(i == 0)begin
					$fwrite(file_handle0, "%d\n",write_content[i]);end
					//$display("reg_psum[%d] = %d,spare_reg_psum[%d] = %d",i,reg_psum[i],i,spare_reg_psum[i])	;end
					if(i == 1)begin
					$fwrite(file_handle1, "%d\n",write_content[i]);end
					if(i == 2)begin
					$fwrite(file_handle2, "%d\n",write_content[i]);end
					if(i == 3)begin
					$fwrite(file_handle3, "%d\n",write_content[i]);end
					if(i == 4)begin
					$fwrite(file_handle4, "%d\n",write_content[i]);end
					if(i == 5)begin
					$fwrite(file_handle5, "%d\n",write_content[i]);end
					if(i == 6)begin
					$fwrite(file_handle6, "%d\n",write_content[i]);end
					if(i == 7)begin
					$fwrite(file_handle7, "%d\n",write_content[i]);end
					if(i == 8)begin
					$fwrite(file_handle8, "%d\n",write_content[i]);end
					if(i == 9)begin
					$fwrite(file_handle9, "%d\n",write_content[i]);end
					if(i == 10)begin
					$fwrite(file_handle10, "%d\n",write_content[i]);end
					if(i == 11)begin
					$fwrite(file_handle11, "%d\n",write_content[i]);end
					if(i == 12)begin
					$fwrite(file_handle12, "%d\n",write_content[i]);end
					if(i == 13)begin
					$fwrite(file_handle13, "%d\n",write_content[i]);end
					if(i == 14)begin
					$fwrite(file_handle14, "%d\n",write_content[i]);end
					if(i == 15)begin
					$fwrite(file_handle15, "%d\n",write_content[i]);end
					
				end
				
				//$display("conv2_output[%d][%d] = %d",((op_out_cnt-i)/8)+(8*i),(op_out_cnt-i)%8,conv2_output[((op_out_cnt-i)/8)+(8*i)][(op_out_cnt-i)%8] + reg_psum[i]);
			end
		end
		op_out_cnt = op_out_cnt+1;
		//$display("op_out_cnt = %d",op_out_cnt);
		if(op_out_cnt%(8*8+15) == 0)begin //每一輪做完都歸零
			#(`CYCLE)
			RECEIVE_conv2_out = 0;
			op_out_cnt = 0;
		
			if(conv2_times == 6)begin//finish conv2
				//----------sim conv2--------input: maxpooling1,conv2_kernel
				
				for(i=0;i<128;i++)begin
					for(j=0;j<8;j++)begin
					sim_conv2_output[i][j] = 16'd0;	
					end
				end
				
				for(num_out=0;num_out<16;num_out++)begin
					for(k=0;k<6;k++)begin//6kernel
						for(r=0;r<8;r++)begin
							for(c=0;c<8;c++)begin
								product = 32'd0;
								for(i=0;i<5;i++)begin
									for(j=0;j<5;j++)begin
										product = sim_maxpool1[(12*k)+r+i][c+j]*conv2_kernel1[(6*num_out)+k][(5*i)+j];//+product;
										sim_conv2_output[(8*num_out)+r][c] = sim_conv2_output[(8*num_out)+r][c]+ $signed(product[25:10]);
									end
								end
							end
						end
					end
				end	
				
				
				//---------------------------
				for(i=0;i<128;i++)begin//bias,ReLu
					for(j=0;j<8;j++)begin
						//if (conv2_output[i][j] != sim_conv2_output[i][j])begin
						//	$display("conv2_output[%d][%d] is wrong!,data = %d",i,j,conv2_output[i][j]);
						//end
						conv2_output[i][j] = conv2_output[i][j]+ bias_conv2[i/8];
						//$display("conv2_output[%d][%d] = %d",i,j,conv2_output[i][j]);
						if(conv2_output[i][j] <0)begin
							conv2_output[i][j] = 0;
						end	
					end
				end
				//----------sim---------------
				for(i=0;i<128;i++)begin//bias,ReLu
					for(j=0;j<8;j++)begin
						//$display("sim_conv2_output[%d][%d] = %d",i,j,sim_conv2_output[i][j]);
						sim_conv2_output[i][j] = sim_conv2_output[i][j]+ bias_conv2[i/8];
						//$display("sim_conv2_output[%d][%d] = %d",i,j,sim_conv2_output[i][j]);
						if(sim_conv2_output[i][j] <0)begin
							sim_conv2_output[i][j] = 0;
						end	
						//$display("sim_conv2_output[%d][%d] = %d",i,j,sim_conv2_output[i][j]);	
					end
				end
				//----------------------------
				for(i=0;i<64;i++)begin//max pooling out(4*4*16)為
					for(j=0;j<4;j++)begin
						temp = conv2_output[(i*2)][(j*2)];
						for(r=0;r<2;r++)begin
							for(c=0;c<2;c++)begin
								if(r ==0 && c == 0)begin
									
								//$display("temp = %d",temp);
								end
								if(conv2_output[(i*2)+r][(j*2)+c]>temp)begin
									temp = conv2_output[(i*2)+r][(j*2)+c];end
							end
						end
						maxpool2[i][j]= temp;
						//$display("maxpool2[%d][%d] = %d",i,j,maxpool2[i][j]);
					end
				end
				//--------sim---------------
				for(i=0;i<64;i++)begin//max pooling out(4*4*16)為
					for(j=0;j<4;j++)begin
						temp = sim_conv2_output[(i*2)][(j*2)];
						for(r=0;r<2;r++)begin
							for(c=0;c<2;c++)begin
								if(sim_conv2_output[(i*2)+r][(j*2)+c]>temp)begin
									temp = sim_conv2_output[(i*2)+r][(j*2)+c];end
							end
						end
						sim_maxpool2[i][j]= temp;
						
					end
				end
				//--------------------------
				for(i=0;i<256;i++)begin//將fc1 input歸零
					for(j=0;j<32;j++)begin
						FC1_input[i][j] = 16'd0;
					end
				end
				
				for(i=0;i<64;i++)begin//變成可輸入的矩陣(32*256)
					for(j=0;j<4;j++)begin
						FC1_input[(4*i)+j][((4*i)+j)%32] = maxpool2[i][j];
						
					end
				end
				for(i=0;i<256;i++)begin//變成可輸入的矩陣(32*256)
					for(j=0;j<32;j++)begin
					//$display("FC1_input[%d][%d] = %d",i,j,FC1_input[i][j]);
					end
				end	
			end	
		end	
	end
end
//======================mapping FC1 input======================
int input_FC1_cnt;
always@(negedge clk) begin
	if(rst ==1)begin
		input_FC1_cnt = 0;end
	else if(op_FC1_en == 1)begin//FC1運算 輸入input
			for(i=0;i<32;i++)begin
					in_activation[i] =  FC1_input[input_FC1_cnt][i];
				//$display("in_activation[%d] = FC1_input[%d][%d]",i,input_FC1_cnt,i);
			end
			input_FC1_cnt = input_FC1_cnt+1;
			if(input_FC1_cnt%32 == 0)begin
				#(`CYCLE)
				op_FC1_en = 0;
				if(input_FC1_cnt == 256)begin
					input_FC1_cnt = 0;
				end
			end	
	end
end
//=====================存取FC1 output,bias ReLU================================

int receive_num_fc1;
reg signed[15:0] sim_FC1_output[119:0];
always @(negedge clk ) begin
	if(rst == 1)begin
	op_out_cnt = 0;
	FC1_round = 0;end
	else if(RECEIVE_FC1_out == 1)begin
			if(op_out_cnt == 0 && FC1_round == 0)begin//初始FC1_output先歸0
				for(i=0;i<120;i++)begin
					FC1_output[i] = 16'd0;
				end
			end
			//$display("FC1_output[%d]+reg_psum[%d] = %d+%d",op_out_cnt+(32*FC1_times),op_out_cnt,FC1_output[op_out_cnt+(32*FC1_times)],reg_psum[op_out_cnt]);
			FC1_output[op_out_cnt+(32*FC1_times)] = FC1_output[op_out_cnt+(32*FC1_times)]+reg_psum[op_out_cnt];
			if(write_condition == 1)begin
					if(op_out_cnt == 0)begin
					$fwrite(file_handle0, "%d\n",write_content[op_out_cnt]);end
					//$display("reg_psum[%d] = %d,spare_reg_psum[%d] = %d",op_out_cnt,reg_psum[op_out_cnt],op_out_cnt,spare_reg_psum[op_out_cnt])	;end
					if(op_out_cnt == 1)begin
					$fwrite(file_handle1, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 2)begin
					$fwrite(file_handle2, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 3)begin
					$fwrite(file_handle3, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 4)begin
					$fwrite(file_handle4, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 5)begin
					$fwrite(file_handle5, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 6)begin
					$fwrite(file_handle6, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 7)begin
					$fwrite(file_handle7, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 8)begin
					$fwrite(file_handle8, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 9)begin
					$fwrite(file_handle9, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 10)begin
					$fwrite(file_handle10, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 11)begin
					$fwrite(file_handle11, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 12)begin
					$fwrite(file_handle12, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 13)begin
					$fwrite(file_handle13, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 14)begin
					$fwrite(file_handle14, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 15)begin
					$fwrite(file_handle15, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 16)begin
					$fwrite(file_handle16, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 17)begin
					$fwrite(file_handle17, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 18)begin
					$fwrite(file_handle18, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 19)begin
					$fwrite(file_handle19, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 20)begin
					$fwrite(file_handle20, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 21)begin
					$fwrite(file_handle21, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 22)begin
					$fwrite(file_handle22, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 23)begin
					$fwrite(file_handle23, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 24)begin
					$fwrite(file_handle24, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 25)begin
					$fwrite(file_handle25, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 26)begin
					$fwrite(file_handle26, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 27)begin
					$fwrite(file_handle27, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 28)begin
					$fwrite(file_handle28, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 29)begin
					$fwrite(file_handle29, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 30)begin
					$fwrite(file_handle30, "%d\n",write_content[op_out_cnt]);end
					if(op_out_cnt == 31)begin
					$fwrite(file_handle31, "%d\n",write_content[op_out_cnt]);end
					
				end
			
			//$display("FC1_output[%d] = %d",op_out_cnt+(32*FC1_times),FC1_output[op_out_cnt+(32*FC1_times)]);
			//$display("reg_psum[%d] = %d",op_out_cnt,reg_psum[op_out_cnt]);
			op_out_cnt = op_out_cnt+1;
			if(FC1_round < 24)begin
				receive_num_fc1 = 32;end
			else begin	
				receive_num_fc1 = 24;end
			if(op_out_cnt == receive_num_fc1)begin
				#(`CYCLE)
				RECEIVE_FC1_out =0;
				op_out_cnt = 0;
				FC1_round = FC1_round+1;
				//$display("FC1_round = %d",FC1_round);
				if(FC1_round%8 == 0 && FC1_round>0)begin
					FC1_times = FC1_times+1;
				end
				if(FC1_round == 32 )begin//bias +relu
					//-----sim FC1----------
					
					for(i=0;i<120;i++)begin
						product = 32'd0;
						sim_FC1_output[i] = 16'd0;
						for(j=0;j<256;j++)begin
							product = sim_maxpool2[j/4][j%4]*FC1[i][j];
							sim_FC1_output[i] = sim_FC1_output[i] + $signed(product[25:10]);
						end
					end
					//----------------------
					//$display("======output FC1 start ReLU=======");
					for(i=0;i<120;i++)begin//bias relu
						//if(FC1_output[i] != sim_FC1_output[i])begin
						//	$display("sim_FC1_output[%d] != FC1_output[%d],data =%d",i,i,FC1_output[i]);
						//end
						FC1_output[i] = FC1_output[i]+bias_FC1[i];
						if(FC1_output[i]<0)begin
						FC1_output[i] = 0;end
					end
					//------sim---------------
					for(i=0;i<120;i++)begin//bias relu
						sim_FC1_output[i] = sim_FC1_output[i]+bias_FC1[i];
						//$display("sim_FC1_output[%d] = %d",i,sim_FC1_output[i]);
						
						if(sim_FC1_output[i]<0)begin
						sim_FC1_output[i] = 0;end
					end
					//------------------------
					for(i=0;i<128;i++)begin//將fc2 input歸零
						for(j=0;j<32;j++)begin
							FC2_input[i][j] = 16'd0;
						end
					end
					for(i=0;i<120;i++)begin
						FC2_input[i][i%32] =  FC1_output[i];
					end
				end
			end
		
	end	
end
//======================mapping FC2 input======================
int input_FC2_cnt;
always@(negedge clk) begin
	if(rst ==1)begin
		input_FC2_cnt = 0;end
	else if(op_FC2_en == 1)begin//FC2運算 輸入input
			for(i=0;i<32;i++)begin
					in_activation[i] =  FC2_input[input_FC2_cnt][i];//$display("in_activation[%d] =%d",i,input_conv1[input_conv1_cnt][i]);
			end
			input_FC2_cnt = input_FC2_cnt+1;
			if(input_FC2_cnt%32 == 0)begin
				#(`CYCLE)
				op_FC2_en = 0;
				if(input_FC2_cnt == 128)begin
					input_FC2_cnt = 0;
				end
			end	
	end
end


//==================存取FC2 output,bias ReLU===============

int receive_num_fc2;
reg signed[15:0] sim_FC2_output[83:0];
always @(negedge clk ) begin
	if(rst == 1)begin
	op_out_cnt = 0;
	FC2_round = 0;end
	else if(RECEIVE_FC2_out == 1)begin
		
			if(op_out_cnt == 0 && FC2_round == 0)begin//初始FC2_output先歸0
				for(i=0;i<84;i++)begin
					FC2_output[i] = 16'd0;
				end
			end
			FC2_output[op_out_cnt+(32*FC2_times)] = FC2_output[op_out_cnt+(32*FC2_times)]+reg_psum[op_out_cnt];
			if(write_condition == 1)begin
				if(op_out_cnt == 0)begin
				$fwrite(file_handle0, "%d\n",write_content[op_out_cnt]);end
				//$display("reg_psum[%d] = %d,spare_reg_psum[%d] = %d",op_out_cnt,reg_psum[op_out_cnt],op_out_cnt,spare_reg_psum[op_out_cnt])	;end
				if(op_out_cnt == 1)begin
				$fwrite(file_handle1, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 2)begin
				$fwrite(file_handle2, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 3)begin
				$fwrite(file_handle3, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 4)begin
				$fwrite(file_handle4, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 5)begin
				$fwrite(file_handle5, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 6)begin
				$fwrite(file_handle6, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 7)begin
				$fwrite(file_handle7, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 8)begin
				$fwrite(file_handle8, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 9)begin
				$fwrite(file_handle9, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 10)begin
				$fwrite(file_handle10, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 11)begin
				$fwrite(file_handle11, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 12)begin
				$fwrite(file_handle12, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 13)begin
				$fwrite(file_handle13, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 14)begin
				$fwrite(file_handle14, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 15)begin
				$fwrite(file_handle15, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 16)begin
				$fwrite(file_handle16, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 17)begin
				$fwrite(file_handle17, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 18)begin
				$fwrite(file_handle18, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 19)begin
				$fwrite(file_handle19, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 20)begin
				$fwrite(file_handle20, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 21)begin
				$fwrite(file_handle21, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 22)begin
				$fwrite(file_handle22, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 23)begin
				$fwrite(file_handle23, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 24)begin
				$fwrite(file_handle24, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 25)begin
				$fwrite(file_handle25, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 26)begin
				$fwrite(file_handle26, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 27)begin
				$fwrite(file_handle27, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 28)begin
				$fwrite(file_handle28, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 29)begin
				$fwrite(file_handle29, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 30)begin
				$fwrite(file_handle30, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 31)begin
				$fwrite(file_handle31, "%d\n",write_content[op_out_cnt]);end
					
				end
			op_out_cnt = op_out_cnt+1;
			if(FC2_round < 8)begin
				receive_num_fc2 = 32;end
			else begin	
				receive_num_fc2 = 20;end
			if(op_out_cnt == receive_num_fc2)begin
				#(`CYCLE)
				RECEIVE_FC2_out =0;
				op_out_cnt = 0;
				FC2_round = FC2_round+1;
				if(FC2_round%4 == 0 && FC2_round>0)begin
					FC2_times = FC2_times+1;
					//$display("FC2_times = ",FC2_times);
				end	
				//$display("FC2_round = %d",FC2_round);
				 
				if(FC2_round == 12 )begin
					//--------sim FC2------
					for(i=0;i<84;i++)begin
						product = 32'd0;
						sim_FC2_output[i] = 16'd0;
						for(j=0;j<120;j++)begin
							product = sim_FC1_output[j]*FC2[i][j];
							if(i == 0)begin
								//$display("fc[%d][%d]:%d = %d * %d",i,j,$signed(product[25:10]),sim_FC1_output[j],FC2[i][j]);
							end
							sim_FC2_output[i] = sim_FC2_output[i] + $signed(product[25:10]);
						end
					end
					//---------------------
					//bias +relu
					//$display("======output FC2 start ReLU=======");
					for(i=0;i<84;i++)begin
						//if(FC2_output[i] != sim_FC2_output[i])begin
						//	$display("sim_FC2_output[%d] != FC2_output[%d],data =%d",i,i,FC2_output[i]);
						//end
						FC2_output[i] = FC2_output[i]+bias_FC2[i];
						if(FC2_output[i]<0)begin
							FC2_output[i] = 0;end
					end
					//-------sim--------
					for(i=0;i<84;i++)begin
						sim_FC2_output[i] = sim_FC2_output[i]+bias_FC2[i];
						if(sim_FC2_output[i]<0)begin
							sim_FC2_output[i] = 0;end
					end
					//------------------
					for(i=0;i<96;i++)begin//將fc3 input歸零
						for(j=0;j<32;j++)begin
							FC3_input[i][j] = 16'd0;
						end
					end
					for(i=0;i<84;i++)begin
						FC3_input[i][i%32] =  FC2_output[i];
						//$display("FC3_input[%d][%d] = %d",i,i%32,FC2_output[i]);
					end
				end
			end
		
	end	
end
//======================mapping FC3 input======================
int input_FC3_cnt;
always@(negedge clk) begin
	if(rst ==1)begin
		input_FC3_cnt = 0;end
	else if(op_FC3_en == 1)begin//FC3運算 輸入input
			for(i=0;i<32;i++)begin
					in_activation[i] =  FC3_input[input_FC3_cnt][i];
					//$display("in_activation[%d] =  %d",i,FC3_input[input_FC3_cnt][i]);
			end
			input_FC3_cnt = input_FC3_cnt+1;
			//$display("input_FC3_cnt = ",input_FC3_cnt);
			if(input_FC3_cnt%32 == 0)begin
				#(`CYCLE)
				op_FC3_en = 0;
				//$display("op_FC3_en = 0");
				if(input_FC3_cnt == 96)begin
					input_FC3_cnt = 0;
				end
			end	
	end
end
//==================存取FC3 output,bias ReLU===============

int receive_num_fc3;
reg signed[15:0] sim_FC3_output[9:0];
always @(negedge clk ) begin
	if(rst == 1)begin
	op_out_cnt = 0;
	FC3_round = 0;end
	else if(RECEIVE_FC3_out == 1)begin
		
			if(op_out_cnt == 0 && FC3_round == 0)begin//初始FC3_output先歸0
				for(i=0;i<10;i++)begin
					FC3_output[i] = 16'd0;
				end
			end
			FC3_output[op_out_cnt] = FC3_output[op_out_cnt]+reg_psum[op_out_cnt];
			if(write_condition == 1)begin
				if(op_out_cnt == 0)begin
				$fwrite(file_handle0, "%d\n",write_content[op_out_cnt]);end
				//$display("reg_psum[%d] = %d,spare_reg_psum[%d] = %d",op_out_cnt,reg_psum[op_out_cnt],op_out_cnt,spare_reg_psum[op_out_cnt])	;end
				if(op_out_cnt == 1)begin
				$fwrite(file_handle1, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 2)begin
				$fwrite(file_handle2, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 3)begin
				$fwrite(file_handle3, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 4)begin
				$fwrite(file_handle4, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 5)begin
				$fwrite(file_handle5, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 6)begin
				$fwrite(file_handle6, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 7)begin
				$fwrite(file_handle7, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 8)begin
				$fwrite(file_handle8, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 9)begin
				$fwrite(file_handle9, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 10)begin
				$fwrite(file_handle10, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 11)begin
				$fwrite(file_handle11, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 12)begin
				$fwrite(file_handle12, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 13)begin
				$fwrite(file_handle13, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 14)begin
				$fwrite(file_handle14, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 15)begin
				$fwrite(file_handle15, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 16)begin
				$fwrite(file_handle16, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 17)begin
				$fwrite(file_handle17, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 18)begin
				$fwrite(file_handle18, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 19)begin
				$fwrite(file_handle19, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 20)begin
				$fwrite(file_handle20, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 21)begin
				$fwrite(file_handle21, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 22)begin
				$fwrite(file_handle22, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 23)begin
				$fwrite(file_handle23, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 24)begin
				$fwrite(file_handle24, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 25)begin
				$fwrite(file_handle25, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 26)begin
				$fwrite(file_handle26, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 27)begin
				$fwrite(file_handle27, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 28)begin
				$fwrite(file_handle28, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 29)begin
				$fwrite(file_handle29, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 30)begin
				$fwrite(file_handle30, "%d\n",write_content[op_out_cnt]);end
				if(op_out_cnt == 31)begin
				$fwrite(file_handle31, "%d\n",write_content[op_out_cnt]);end
					
				end
			//$display("op_out_cnt = %d",op_out_cnt);
			//$display("FC3_output[%d] = %d",op_out_cnt,FC3_output[op_out_cnt]);
			//$display("reg_psum3[%d] = %d",op_out_cnt,reg_psum[op_out_cnt]);
			op_out_cnt = op_out_cnt+1;
			
			if(op_out_cnt == 10)begin
				#(`CYCLE)
				RECEIVE_FC3_out =0;
				op_out_cnt = 0;
				FC3_round = FC3_round+1;
				$display("FC3_round = %d",FC3_round);
				 
				if(FC3_round == 3 )begin
					//------sim FC3---------
					for(i=0;i<10;i++)begin
						product = 32'd0;
						sim_FC3_output[i] = 16'd0;
						for(j=0;j<84;j++)begin
							product = (sim_FC2_output[j]*FC3[i][j]);
							if(i == 0)begin
								//$display("fc[%d][%d]:%d = %d * %d",i,j,$signed(product[25:10]),sim_FC2_output[j],FC3[i][j]);
							end
							sim_FC3_output[i] = sim_FC3_output[i]+$signed(product[25:10]);
						end
					end 
					
					//$display("======output FC3 start ReLU======="); 
					for(i=0;i<10;i++)begin//bias +relu
						//if(FC3_output[i] != sim_FC3_output[i])begin
						//	$display("sim_FC3_output[%d] != FC3_output[%d],data =%d",i,i,FC3_output[i]);
						//end
						FC3_output[i] = FC3_output[i]+bias_FC3[i];
						if(FC3_output[i]<0)begin
							FC3_output[i] = 0;end
						$display("FC3_output[%d]  =%d",i,FC3_output[i]);	
					end
					//--------sim
					for(i=0;i<10;i++)begin//bias +relu
						sim_FC3_output[i] = sim_FC3_output[i]+bias_FC3[i];
						if(sim_FC3_output[i]<0)begin
							sim_FC3_output[i] = 0;end	
					end
					//-----------
					
				end
			end
		
	end	
end
//==================predict======================
int champion;
int champion_value;

task IS_IT_ACC;begin
		
		champion = 0;
		champion_value = 0;
		is_it_acc = 0;
		
		for(i=0;i<10;i++)begin
			if(FC3_output[i] > champion_value)begin
				champion_value = FC3_output[i];
				champion = i;
			end
		end
		
		$display("Label_now == %d",Label_now);
		$display("predic_Label == %d",champion);
		if(Label_now == champion)begin
			acc_num =  acc_num+1;
			
			$display("//============----------------------------=============//");
			$display("//================predict correct!!====================//");
			$display("//============----------------------------==========//");
		end
		else begin
		is_it_acc = 0;
		$display("//=============----------------------------============//");
			$display("//================predict wrong :((====================//");
			$display("//==========----------------------------=============//");
		end
		
	end	
endtask

always begin
   #5 clk = ~clk;
end

endmodule