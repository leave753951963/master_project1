//for官方alexnet pytorch架構
`timescale 1ns / 1ps
`include "./FSA_SA64_random_fault.v"
`define CYCLE 		10.0
`define End_CYCLE  	10000000
`define WEIGHT	"/home/wzc/master_project/alexnet_pth/weight/weight_4df8aa71_32bit.dat"
`define INPUT	"/home/wzc/master_project/alexnet-pytorch-master/alexnet_data_in/input_data.txt"


module tb_SA64;
  reg weight_en;
  reg clk,rst;
  reg signed[31:0]   in_weight[0:63];
  reg signed[31:0]   in_psum[0:63];
  reg signed[31:0]   in_activation[0:63];
  wire signed[31:0]   reg_psum[0:63];
  wire signed[31:0]   spare_reg_psum[0:63];

  SA64   cut1(.rst(rst), .clk(clk), .weight_en(weight_en), .in_weight_0(in_weight[0]), .in_psum_0(in_psum[0]), .in_weight_1(in_weight[1]), .in_psum_1(in_psum[1]), .in_weight_2(in_weight[2]), .in_psum_2(in_psum[2]), .in_weight_3(in_weight[3]), .in_psum_3(in_psum[3]), .in_weight_4(in_weight[4]), .in_psum_4(in_psum[4]), .in_weight_5(in_weight[5]), .in_psum_5(in_psum[5]), .in_weight_6(in_weight[6]), .in_psum_6(in_psum[6]), .in_weight_7(in_weight[7]), .in_psum_7(in_psum[7]), .in_weight_8(in_weight[8]), .in_psum_8(in_psum[8]), .in_weight_9(in_weight[9]), .in_psum_9(in_psum[9]), .in_weight_10(in_weight[10]), .in_psum_10(in_psum[10]), .in_weight_11(in_weight[11]), .in_psum_11(in_psum[11]), .in_weight_12(in_weight[12]), .in_psum_12(in_psum[12]), .in_weight_13(in_weight[13]), .in_psum_13(in_psum[13]), .in_weight_14(in_weight[14]), .in_psum_14(in_psum[14]), .in_weight_15(in_weight[15]), .in_psum_15(in_psum[15]), .in_weight_16(in_weight[16]), .in_psum_16(in_psum[16]), .in_weight_17(in_weight[17]), .in_psum_17(in_psum[17]), .in_weight_18(in_weight[18]), .in_psum_18(in_psum[18]), .in_weight_19(in_weight[19]), .in_psum_19(in_psum[19]), .in_weight_20(in_weight[20]), .in_psum_20(in_psum[20]), .in_weight_21(in_weight[21]), .in_psum_21(in_psum[21]), .in_weight_22(in_weight[22]), .in_psum_22(in_psum[22]), .in_weight_23(in_weight[23]), .in_psum_23(in_psum[23]), .in_weight_24(in_weight[24]), .in_psum_24(in_psum[24]), .in_weight_25(in_weight[25]), .in_psum_25(in_psum[25]), .in_weight_26(in_weight[26]), .in_psum_26(in_psum[26]), .in_weight_27(in_weight[27]), .in_psum_27(in_psum[27]), .in_weight_28(in_weight[28]), .in_psum_28(in_psum[28]), .in_weight_29(in_weight[29]), .in_psum_29(in_psum[29]), .in_weight_30(in_weight[30]), .in_psum_30(in_psum[30]), .in_weight_31(in_weight[31]), .in_psum_31(in_psum[31]), .in_weight_32(in_weight[32]), .in_psum_32(in_psum[32]), .in_weight_33(in_weight[33]), .in_psum_33(in_psum[33]), .in_weight_34(in_weight[34]), .in_psum_34(in_psum[34]), .in_weight_35(in_weight[35]), .in_psum_35(in_psum[35]), .in_weight_36(in_weight[36]), .in_psum_36(in_psum[36]), .in_weight_37(in_weight[37]), .in_psum_37(in_psum[37]), .in_weight_38(in_weight[38]), .in_psum_38(in_psum[38]), .in_weight_39(in_weight[39]), .in_psum_39(in_psum[39]), .in_weight_40(in_weight[40]), .in_psum_40(in_psum[40]), .in_weight_41(in_weight[41]), .in_psum_41(in_psum[41]), .in_weight_42(in_weight[42]), .in_psum_42(in_psum[42]), .in_weight_43(in_weight[43]), .in_psum_43(in_psum[43]), .in_weight_44(in_weight[44]), .in_psum_44(in_psum[44]), .in_weight_45(in_weight[45]), .in_psum_45(in_psum[45]), .in_weight_46(in_weight[46]), .in_psum_46(in_psum[46]), .in_weight_47(in_weight[47]), .in_psum_47(in_psum[47]), .in_weight_48(in_weight[48]), .in_psum_48(in_psum[48]), .in_weight_49(in_weight[49]), .in_psum_49(in_psum[49]), .in_weight_50(in_weight[50]), .in_psum_50(in_psum[50]), .in_weight_51(in_weight[51]), .in_psum_51(in_psum[51]), .in_weight_52(in_weight[52]), .in_psum_52(in_psum[52]), .in_weight_53(in_weight[53]), .in_psum_53(in_psum[53]), .in_weight_54(in_weight[54]), .in_psum_54(in_psum[54]), .in_weight_55(in_weight[55]), .in_psum_55(in_psum[55]), .in_weight_56(in_weight[56]), .in_psum_56(in_psum[56]), .in_weight_57(in_weight[57]), .in_psum_57(in_psum[57]), .in_weight_58(in_weight[58]), .in_psum_58(in_psum[58]), .in_weight_59(in_weight[59]), .in_psum_59(in_psum[59]), .in_weight_60(in_weight[60]), .in_psum_60(in_psum[60]), .in_weight_61(in_weight[61]), .in_psum_61(in_psum[61]), .in_weight_62(in_weight[62]), .in_psum_62(in_psum[62]), .in_weight_63(in_weight[63]), .in_psum_63(in_psum[63]), .in_activation_0(in_activation[0]), .in_activation_1(in_activation[1]), .in_activation_2(in_activation[2]), .in_activation_3(in_activation[3]), .in_activation_4(in_activation[4]), .in_activation_5(in_activation[5]), .in_activation_6(in_activation[6]), .in_activation_7(in_activation[7]), .in_activation_8(in_activation[8]), .in_activation_9(in_activation[9]), .in_activation_10(in_activation[10]), .in_activation_11(in_activation[11]), .in_activation_12(in_activation[12]), .in_activation_13(in_activation[13]), .in_activation_14(in_activation[14]), .in_activation_15(in_activation[15]), .in_activation_16(in_activation[16]), .in_activation_17(in_activation[17]), .in_activation_18(in_activation[18]), .in_activation_19(in_activation[19]), .in_activation_20(in_activation[20]), .in_activation_21(in_activation[21]), .in_activation_22(in_activation[22]), .in_activation_23(in_activation[23]), .in_activation_24(in_activation[24]), .in_activation_25(in_activation[25]), .in_activation_26(in_activation[26]), .in_activation_27(in_activation[27]), .in_activation_28(in_activation[28]), .in_activation_29(in_activation[29]), .in_activation_30(in_activation[30]), .in_activation_31(in_activation[31]), .in_activation_32(in_activation[32]), .in_activation_33(in_activation[33]), .in_activation_34(in_activation[34]), .in_activation_35(in_activation[35]), .in_activation_36(in_activation[36]), .in_activation_37(in_activation[37]), .in_activation_38(in_activation[38]), .in_activation_39(in_activation[39]), .in_activation_40(in_activation[40]), .in_activation_41(in_activation[41]), .in_activation_42(in_activation[42]), .in_activation_43(in_activation[43]), .in_activation_44(in_activation[44]), .in_activation_45(in_activation[45]), .in_activation_46(in_activation[46]), .in_activation_47(in_activation[47]), .in_activation_48(in_activation[48]), .in_activation_49(in_activation[49]), .in_activation_50(in_activation[50]), .in_activation_51(in_activation[51]), .in_activation_52(in_activation[52]), .in_activation_53(in_activation[53]), .in_activation_54(in_activation[54]), .in_activation_55(in_activation[55]), .in_activation_56(in_activation[56]), .in_activation_57(in_activation[57]), .in_activation_58(in_activation[58]), .in_activation_59(in_activation[59]), .in_activation_60(in_activation[60]), .in_activation_61(in_activation[61]), .in_activation_62(in_activation[62]), .in_activation_63(in_activation[63]), .out_psum_0(reg_psum[0]), .out_psum_1(reg_psum[1]), .out_psum_2(reg_psum[2]), .out_psum_3(reg_psum[3]), .out_psum_4(reg_psum[4]), .out_psum_5(reg_psum[5]), .out_psum_6(reg_psum[6]), .out_psum_7(reg_psum[7]), .out_psum_8(reg_psum[8]), .out_psum_9(reg_psum[9]), .out_psum_10(reg_psum[10]), .out_psum_11(reg_psum[11]), .out_psum_12(reg_psum[12]), .out_psum_13(reg_psum[13]), .out_psum_14(reg_psum[14]), .out_psum_15(reg_psum[15]), .out_psum_16(reg_psum[16]), .out_psum_17(reg_psum[17]), .out_psum_18(reg_psum[18]), .out_psum_19(reg_psum[19]), .out_psum_20(reg_psum[20]), .out_psum_21(reg_psum[21]), .out_psum_22(reg_psum[22]), .out_psum_23(reg_psum[23]), .out_psum_24(reg_psum[24]), .out_psum_25(reg_psum[25]), .out_psum_26(reg_psum[26]), .out_psum_27(reg_psum[27]), .out_psum_28(reg_psum[28]), .out_psum_29(reg_psum[29]), .out_psum_30(reg_psum[30]), .out_psum_31(reg_psum[31]), .out_psum_32(reg_psum[32]), .out_psum_33(reg_psum[33]), .out_psum_34(reg_psum[34]), .out_psum_35(reg_psum[35]), .out_psum_36(reg_psum[36]), .out_psum_37(reg_psum[37]), .out_psum_38(reg_psum[38]), .out_psum_39(reg_psum[39]), .out_psum_40(reg_psum[40]), .out_psum_41(reg_psum[41]), .out_psum_42(reg_psum[42]), .out_psum_43(reg_psum[43]), .out_psum_44(reg_psum[44]), .out_psum_45(reg_psum[45]), .out_psum_46(reg_psum[46]), .out_psum_47(reg_psum[47]), .out_psum_48(reg_psum[48]), .out_psum_49(reg_psum[49]), .out_psum_50(reg_psum[50]), .out_psum_51(reg_psum[51]), .out_psum_52(reg_psum[52]), .out_psum_53(reg_psum[53]), .out_psum_54(reg_psum[54]), .out_psum_55(reg_psum[55]), .out_psum_56(reg_psum[56]), .out_psum_57(reg_psum[57]), .out_psum_58(reg_psum[58]), .out_psum_59(reg_psum[59]), .out_psum_60(reg_psum[60]), .out_psum_61(reg_psum[61]), .out_psum_62(reg_psum[62]), .out_psum_63(reg_psum[63]));

int k,r,c,i,j;
integer fp_r;
int Label[0:999];
int Label_now;
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
    in_weight[32] = 0;
    in_psum[32] = 0;
    in_weight[33] = 0;
    in_psum[33] = 0;
    in_weight[34] = 0;
    in_psum[34] = 0;
    in_weight[35] = 0;
    in_psum[35] = 0;
    in_weight[36] = 0;
    in_psum[36] = 0;
    in_weight[37] = 0;
    in_psum[37] = 0;
    in_weight[38] = 0;
    in_psum[38] = 0;
    in_weight[39] = 0;
    in_psum[39] = 0;
    in_weight[40] = 0;
    in_psum[40] = 0;
    in_weight[41] = 0;
    in_psum[41] = 0;
    in_weight[42] = 0;
    in_psum[42] = 0;
    in_weight[43] = 0;
    in_psum[43] = 0;
    in_weight[44] = 0;
    in_psum[44] = 0;
    in_weight[45] = 0;
    in_psum[45] = 0;
    in_weight[46] = 0;
    in_psum[46] = 0;
    in_weight[47] = 0;
    in_psum[47] = 0;
    in_weight[48] = 0;
    in_psum[48] = 0;
    in_weight[49] = 0;
    in_psum[49] = 0;
    in_weight[50] = 0;
    in_psum[50] = 0;
    in_weight[51] = 0;
    in_psum[51] = 0;
    in_weight[52] = 0;
    in_psum[52] = 0;
    in_weight[53] = 0;
    in_psum[53] = 0;
    in_weight[54] = 0;
    in_psum[54] = 0;
    in_weight[55] = 0;
    in_psum[55] = 0;
    in_weight[56] = 0;
    in_psum[56] = 0;
    in_weight[57] = 0;
    in_psum[57] = 0;
    in_weight[58] = 0;
    in_psum[58] = 0;
    in_weight[59] = 0;
    in_psum[59] = 0;
    in_weight[60] = 0;
    in_psum[60] = 0;
    in_weight[61] = 0;
    in_psum[61] = 0;
    in_weight[62] = 0;
    in_psum[62] = 0;
    in_weight[63] = 0;
    in_psum[63] = 0;
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
    in_activation[32] = 0;
    in_activation[33] = 0;
    in_activation[34] = 0;
    in_activation[35] = 0;
    in_activation[36] = 0;
    in_activation[37] = 0;
    in_activation[38] = 0;
    in_activation[39] = 0;
    in_activation[40] = 0;
    in_activation[41] = 0;
    in_activation[42] = 0;
    in_activation[43] = 0;
    in_activation[44] = 0;
    in_activation[45] = 0;
    in_activation[46] = 0;
    in_activation[47] = 0;
    in_activation[48] = 0;
    in_activation[49] = 0;
    in_activation[50] = 0;
    in_activation[51] = 0;
    in_activation[52] = 0;
    in_activation[53] = 0;
    in_activation[54] = 0;
    in_activation[55] = 0;
    in_activation[56] = 0;
    in_activation[57] = 0;
    in_activation[58] = 0;
    in_activation[59] = 0;
    in_activation[60] = 0;
    in_activation[61] = 0;
    in_activation[62] = 0;
    in_activation[63] = 0;
$display("----------------------");
$display("-- Simulation Start --");
$display("----------------------");
end

 
//========================declare==================================
reg signed[31:0]	Input_mem[0:(224*224*3*1000)-1];
reg signed[31:0]	Input_feature[(224*3)-1:0][223:0];//224*224*3

reg signed[31:0]	conv1_padding[(227*3)-1:0][226:0];//227*227*3
reg signed[31:0]	Input_conv1[18527:0][63:0];//(55x55+63)x2x3
reg signed[31:0]	Conv1_kernel[191:0][120:0];//[64x3,11x11],11x11的矩陣
reg signed[31:0]	Conv1_output[3519:0][54:0];//[64x55,55],64個55x55矩陣
reg signed[31:0]	Bias_conv1[63:0];//conv1輸出64個feature map
reg signed[31:0]	Maxpool1_output[1727:0][26:0];//27x27有64個

reg signed[31:0]	conv2_padding[(31*64)-1:0][30:0];//31*31*64
reg signed[31:0]	Input_conv2[24895:0][49:0];
reg signed[31:0]	Conv2_kernel[12287:0][24:0];//5x5kernel,64x192個
reg signed[31:0]	Conv2_output[5183:0][26:0];//27x27x192
reg signed[31:0]	Bias_conv2[191:0];
reg signed[31:0]	Maxpool2_output[2495:0][12:0];//13x13有192

reg signed[31:0]	conv3_padding[(15*192)-1:0][14:0];//15*15*192
reg signed[31:0]	Input_conv3[6467:0][62:0];//[(13x13+62)x28,7x(3x3)]
reg signed[31:0]	Conv3_kernel[73727:0][8:0];//192x384,(3x3)
reg signed[31:0]	Conv3_output[4991:0][12:0];//13x13x384
reg signed[31:0]	Bias_conv3[383:0];

reg signed[31:0]	conv4_padding[(15*384)-1:0][14:0];//15*15*384
reg signed[31:0]	Input_conv4[12704:0][62:0];//[(13x13+62)x55,7x(3x3)]
reg signed[31:0]	Conv4_kernel[98303:0][8:0];//[384x256,(3x3)]
reg signed[31:0]	Conv4_output[3327:0][12:0];//13x13,256個
reg signed[31:0]	Bias_conv4[255:0];//輸出256個feature

reg signed[31:0]	conv5_padding[(15*256)-1:0][14:0];//15*15*256
reg signed[31:0]	Input_conv5[8546:0][62:0];//[(13x13+62)x37,3x3x7]
reg signed[31:0]	Conv5_kernel[65535:0][8:0];//256x256,9
reg signed[31:0]	Conv5_output[3327:0][12:0];//13x13x256
reg signed[31:0]	Bias_conv5[255:0];
reg signed[31:0]	Maxpool3_output[1535:0][5:0];//6X6X256

reg signed[31:0]	Input_FC1[9215:0][63:0];//9216x64
reg signed[31:0]	FC1_weight[4095:0][9215:0]; 
reg signed[31:0]	FC1_output[4095:0];
reg signed[31:0]	Bias_fc1[4095:0];

reg signed[31:0]	Input_FC2[4095:0][63:0];//4096x64
reg signed[31:0]	FC2_weight[4095:0][4095:0];//4096x4096
reg signed[31:0]	FC2_output[4095:0];
reg signed[31:0]	Bias_fc2[4095:0];

reg signed[31:0]	Input_FC3[4095:0][63:0];//4096x64
reg signed[31:0]	FC3_weight[999:0][4095:0];//1000x4096
reg signed[31:0]	FC3_output[999:0];
reg signed[31:0]	Bias_fc3[999:0];
//==================read input=========================

initial begin 
//--------fault info-------------
//fp_r=$fopen(`FAULT_INFO,"r");
//if (fp_r == 0)begin
//    $display ("FAULT_INFO pattern handle null");
//       $finish;
//   end
//$fscanf(fp_r,"%d",fault_column);
//$fscanf(fp_r,"%s",output_file1);
//$fscanf(fp_r,"%s",output_file2);
//$display("fault_column = %d",fault_column);
//$fclose(fp_r);	
//-------------------------------

fp_r=$fopen(`INPUT,"r");
if (fp_r == 0)begin
    $display ("INPUT pattern handle null");
       $finish;
end
for(i=0;i<1000;i++)begin
	$fscanf(fp_r,"%d",Label[i]);
	for(j=0;j<224*224*3;j++)begin
		$fscanf(fp_r,"%b",Input_mem[j+(i*224*224*3)]);
		//$display("Input_mem[%d] = %d",j,Input_mem[j]);
	end
end	
	//for (i=0;i<28;i++) begin//28*28 input
	//	for(j=0;j<28;j++)begin
	//		$fscanf(fp_r,"%b",Input_feature[i][j]);
	//		//$display("Input_feature[%d][%d]==%d",i,j,Input_feature[i][j]);
	//	end
	//end	    

$fclose(fp_r);	

//==================read weight========================
fp_r=$fopen(`WEIGHT,"r");
if (fp_r == 0)begin
    $display ("WEIGHT pattern handle null");
       $finish;
   end
$display("open the file successfully");
//while(!$feof(fp_r))
for (i=0;i<192;i++) begin//conv1
	for(j=0;j<121;j++)begin
		$fscanf(fp_r,"%b",Conv1_kernel[i][j]);
		//$display("Conv1_kernel[%d][%d]==%d",i,j,Conv1_kernel[i][j]);
	end
end	
for (i=0;i<64;i++) begin//bias conv1
	$fscanf(fp_r,"%b",Bias_conv1[i]);
	//$display("Bias_conv1[%d]==%b",i,Bias_conv1[i]);
end	
//------------ 
for (i=0;i<12288;i++) begin//conv2
	for(j=0;j<25;j++)begin
		$fscanf(fp_r,"%b",Conv2_kernel[i][j]);
	//$display("Conv2_kernel[%d][%d]==%d",i,j,Conv2_kernel[i][j]);
	end
end		
for (i=0;i<192;i++) begin//bias conv2
	$fscanf(fp_r,"%b",Bias_conv2[i]);
	//$display("Bias_conv2[%d]==%d",i,Bias_conv2[i]);
end	
//-----------
for (i=0;i<73728;i++) begin//conv3
	for(j=0;j<9;j++)begin
	$fscanf(fp_r,"%b",Conv3_kernel[i][j]);
	//$display("Conv3_kernel[%d][%d]==%d",i,j,Conv3_kernel[i][j]);
	end
end		
for (i=0;i<384;i++) begin//bias conv3
	$fscanf(fp_r,"%b",Bias_conv3[i]);
	//$display("Bias_conv3[%d]==%d",i,Bias_conv3[i]);
end	
//-----------
for (i=0;i<98304;i++) begin//conv4
	for(j=0;j<9;j++)begin
	$fscanf(fp_r,"%b",Conv4_kernel[i][j]);
	//$display("Conv4_kernel[%d][%d]==%d",i,j,Conv4_kernel[i][j]);
	end
end		
for (i=0;i<256;i++) begin//bias conv4
	$fscanf(fp_r,"%b",Bias_conv4[i]);
	//$display("Bias_conv4[%d]==%d",i,Bias_conv4[i]);
end	
//-----------
for (i=0;i<65536;i++) begin//conv5
	for(j=0;j<9;j++)begin
	$fscanf(fp_r,"%b",Conv5_kernel[i][j]);
	//$display("Conv5_kernel[%d][%d]==%d",i,j,Conv5_kernel[i][j]);
	end
end		
for (i=0;i<256;i++) begin//bias conv5
	$fscanf(fp_r,"%b",Bias_conv5[i]);
	//$display("Bias_conv5[%d]==%d",i,Bias_conv5[i]);
end	
//-----------
for (i=0;i<4096;i++) begin//FC1
	for(j=0;j<9216;j++)begin
	$fscanf(fp_r,"%b",FC1_weight[i][j]);
	//$display("FC1_weight[%d][%d]==%b",i,j,FC1_weight[i][j]);
	end
end		
for (i=0;i<4096;i++) begin//bias_FC1
	$fscanf(fp_r,"%b",Bias_fc1[i]);
	//$display("Bias_fc1[%d]==%b",i,Bias_fc1[i]);
end	
//-----------
for (i=0;i<4096;i++) begin//FC2
	for(j=0;j<4096;j++)begin
		$fscanf(fp_r,"%b",FC2_weight[i][j]);
	end	
end		
for (i=0;i<4096;i++) begin//bias_FC2
	$fscanf(fp_r,"%b",Bias_fc2[i]);
	//$display("Bias_fc2[%d]==%b",i,Bias_fc2[i]);
end	
//-------------
for (i=0;i<1000;i++) begin//FC3
	for(j=0;j<4096;j++)begin
		$fscanf(fp_r,"%b",FC3_weight[i][j]);
		//$display("FC3_weight[%d][%d]==%b",i,j,FC3_weight[i][j]);
	end
end		
for (i=0;i<1000;i++) begin//bias_FC3
	$fscanf(fp_r,"%b",Bias_fc3[i]);
	//$display("Bias_fc3[%d]==%b",i,Bias_fc3[i]);
end	
$fclose(fp_r);		
$display("-----------weight load finish--------------"); 
end

//=====================control=========================
int champion[0:4];
int champion_value[0:4]; 
int Conv1_weight_en,Conv2_weight_en,Conv3_weight_en,Conv4_weight_en,Conv5_weight_en,FC1_weight_en,FC2_weight_en,FC3_weight_en;
int op_conv1_en,op_conv2_en,op_conv3_en,op_conv4_en,op_conv5_en,op_FC1_en,op_FC2_en,op_FC3_en;
int RECEIVE_conv1_out,RECEIVE_conv2_out,RECEIVE_conv3_out,RECEIVE_conv4_out,RECEIVE_conv5_out,RECEIVE_FC1_out,RECEIVE_FC2_out,RECEIVE_FC3_out;
int test_num,acc_num;
initial begin
	acc_num = 0;
	for(test_num=0;test_num<100;test_num++)begin
		#(`CYCLE)
		@(negedge clk);	rst = 1'b1;
		#(`CYCLE*2);
		@(negedge clk);	rst = 1'b0;
		Label_now = Label[test_num+100]; 
		//Input_feature
		for (i=0;i<224*3;i++) begin//28*28 input
			for(j=0;j<224;j++)begin
				Input_feature[i][j] = Input_mem[(i*224)+j+(test_num*(224*224*3))+100*(224*224*3)];
				//$display("Input_feature[%d][%d]==%d",i,j,Input_feature[i][j]);
			end
		end	
		
		
		initialize_input_conv1;
		//
		$display("conv1 start");
		repeat(6)begin //conv1
			#`CYCLE weight_en = 1;Conv1_weight_en =1;
			wait(Conv1_weight_en == 0); op_conv1_en = 1;
			#(`CYCLE*65);RECEIVE_conv1_out = 1;wait(RECEIVE_conv1_out == 0);
		end
		repeat(96)begin//conv2
			#`CYCLE weight_en = 1;Conv2_weight_en =1;
			wait(Conv2_weight_en == 0); op_conv2_en = 1;
			#(`CYCLE*65);RECEIVE_conv2_out = 1;wait(RECEIVE_conv2_out == 0);
		end
		repeat(168)begin//conv3
			#`CYCLE weight_en = 1;Conv3_weight_en =1;
			wait(Conv3_weight_en == 0); op_conv3_en = 1;
			#(`CYCLE*65);RECEIVE_conv3_out = 1;wait(RECEIVE_conv3_out == 0);
		end
		repeat(220)begin//conv4
			#`CYCLE weight_en = 1;Conv4_weight_en =1;
			wait(Conv4_weight_en == 0); op_conv4_en = 1;
			#(`CYCLE*65);RECEIVE_conv4_out = 1;wait(RECEIVE_conv4_out == 0);
		end
		repeat(148)begin//conv5
			#`CYCLE weight_en = 1;Conv5_weight_en =1;
			wait(Conv5_weight_en == 0); op_conv5_en = 1;
			#(`CYCLE*65);RECEIVE_conv5_out = 1;wait(RECEIVE_conv5_out == 0);
		end
		repeat(9216)begin
			#`CYCLE weight_en = 1;FC1_weight_en =1;
			wait(FC1_weight_en == 0); op_FC1_en = 1;
			#(`CYCLE*65);RECEIVE_FC1_out = 1;wait(RECEIVE_FC1_out == 0);
		end
		repeat(4096)begin
			#`CYCLE weight_en = 1;FC2_weight_en =1;
			wait(FC2_weight_en == 0); op_FC2_en = 1;
			#(`CYCLE*65);RECEIVE_FC2_out = 1;wait(RECEIVE_FC2_out == 0);
		end
		repeat(1024)begin
			#`CYCLE weight_en = 1;FC3_weight_en =1;
			wait(FC3_weight_en == 0); op_FC3_en = 1;
			#(`CYCLE*65);RECEIVE_FC3_out = 1;wait(RECEIVE_FC3_out == 0);
		end
		
		PREDICT;
		for(i=0;i<5;i++)begin
			if(Label_now == champion[i])begin
				acc_num =  acc_num+1;
			end	
		end	
		$display("---------groundtruth Label = %d--------",Label_now);
		//$display("---------predict Label = %d --------",champion[0],champion[1],champion[2],champion[3],champion[4]);
		$display("--------acc_num = %d----------",acc_num);
		$display("--------total predict num = %d",test_num+1);
		#(`CYCLE)
		@(negedge clk);	rst = 1'b1;
		#(`CYCLE*2);
		@(negedge clk);	rst = 1'b0;
	end
	#10000 $finish;	
end
//==========img input  img2col=========================

task initialize_input_conv1; 

for(r=0;r<3088*6;r++)begin//先把整個矩陣歸0
	for(c=0;c<64;c++)begin
		Input_conv1[r][c] = 0;
		//$display("input_conv1[%d][%d]",r,c);			
	end
end
//-------padding左2右1(部會運算到227column)-------
for(i=0;i<227*3;i++)begin//conv1 前置的padding後矩陣
	for(j=0;j<227;j++)begin
		conv1_padding[i][j] = 32'd0;
	end
end	
for(k=0;k<3;k++)begin
	for(i=0;i<224;i++)begin
		for(j=0;j<224;j++)begin
			conv1_padding[(k*227)+i+2][j+2] = Input_feature[(k*224)+i][j];
			//$display("conv1_padding[%d][%d] = %d",i,j,conv1_padding[i][j]);
		end	
	end
end	



//stride = 4//---------------img2col------------
for(k=0;k<3;k++)begin	
	for(r=0;r<55;r++)begin//轉好的矩陣
		for(c=0;c<55;c++)begin
			for(i=0;i<11;i++)begin
				for(j=0;j<11;j++)begin
					Input_conv1[(3088*2*k)+(((11*i)+j)/64)*3088+(((11*i)+j)%64)+(55*r)+c][((11*i)+j)%64] = conv1_padding[i+(r*4)+(k*227)][j+(c*4)];
					//$display("input_conv1[%d][%d] = %d",(5*i)+j+(24*r)+c,(5*i)+j,Input_feature[i+r][j+c]);
				end
			end
		end
	end	
end

endtask
//================mapping conv1 input==================
int input_conv1_cnt;

always@(negedge clk) begin
	if(rst ==1)begin
		input_conv1_cnt = 0;end
	else if(op_conv1_en == 1)begin//conv1運算 輸入input
			for(i=0;i<64;i++)begin//
				in_activation[i] =  Input_conv1[input_conv1_cnt][i];
				//$display("in_activation[%d] =%d",i,input_conv1[input_conv1_cnt][i]);
			end
			input_conv1_cnt = input_conv1_cnt+1;
			if(input_conv1_cnt%3088 == 0)begin
				if (input_conv1_cnt == 18528)begin
					input_conv1_cnt = 0;
				end
				#(`CYCLE)
				op_conv1_en = 0;
			end	
	end
end
//===============mapping weight =======================
//========CONV1 weight =====
int Conv1_count ;
reg Conv1_up_or_down ;
int Conv1_times;
always@(negedge clk)begin
	if(rst == 1)begin
		Conv1_count = 0;
		Conv1_times = 0;
		Conv1_up_or_down = 0;
	end
	else if(Conv1_weight_en == 1)begin
		if(Conv1_count ==0)begin
			//$display("----------conv1_weight is being transmitted----------");
		end
		
		if(Conv1_up_or_down == 0)begin //up mapping
			for(i=0;i< 64;i++)begin
				in_weight[i] = Conv1_kernel[i*3+(Conv1_times/2)][63-Conv1_count];
			end
		end	
		if(Conv1_up_or_down == 1)begin //down mapping
			for(i=0;i< 64;i++)begin
				in_weight[i] = Conv1_kernel[i*3+(Conv1_times/2)][120-Conv1_count];
			end
		end
		
		
		Conv1_count = Conv1_count +1;
		if((Conv1_up_or_down == 0 && Conv1_count == 64)||(Conv1_up_or_down == 1 && Conv1_count == 57))begin
			#(`CYCLE)
			Conv1_count = 0;
			weight_en = 0;
			Conv1_weight_en = 0;
			Conv1_times = Conv1_times +1;
			Conv1_up_or_down = ~Conv1_up_or_down;

				
		end		
	end
end
//========CONV2 weight =====
int Conv2_count ;
int Conv2_times ;
always@(negedge clk)begin
	if(rst == 1)begin
		Conv2_count = 0;
		Conv2_times = 0;
	end
	else if(Conv2_weight_en == 1)begin
		if(Conv2_count ==0)begin
			//$display("----------conv2_weight is being transmitted----------");
		end
		for(i=0;i< 64;i++)begin
			in_weight[i] = Conv2_kernel[(Conv2_times/32)*64*64+(i*64)+(Conv2_times%32)*2+(Conv2_count/25)][24-(Conv2_count%25)];
		end
		Conv2_count = Conv2_count+1;
		if(Conv2_count == 50)begin
			#(`CYCLE)
			Conv2_count = 0;
			Conv2_weight_en = 0;
			weight_en = 0;
			Conv2_times = Conv2_times+1;
		end
	end
end
//========CONV3 weight =====
int Conv3_count;
int Conv3_times;
always@(negedge clk)begin
	if(rst == 1)begin
		Conv3_count = 0;
		Conv3_times = 0;
	end
	else if(Conv3_weight_en == 1)begin
		if(Conv3_count == 0)begin
			//$display("----------conv3_weight is being transmitted----------");
		end
		for(i=0;i<64;i++)begin//mapping
			in_weight[i] = Conv3_kernel[(i*192)+(Conv3_count/9)+(Conv3_times/28)*192*64+(Conv3_times%28)*7][8-(Conv3_count%9)];
		end
		Conv3_count = Conv3_count+1;
		if(Conv3_times%28 == 27)begin
			if(Conv3_count == 27)begin//9*3最後一組每欄只有3個kernel
				#(`CYCLE)
				Conv3_count = 0;
				Conv3_weight_en = 0;
				weight_en = 0;
				Conv3_times = Conv3_times + 1;
			end
		end
		if(Conv3_count == 63)begin
			#(`CYCLE)
			Conv3_count = 0;
			Conv3_weight_en = 0;
			weight_en = 0;
			Conv3_times = Conv3_times + 1;
		end
	end
end
//========CONV4 weight =====
int Conv4_count;
int Conv4_times;
always@(negedge clk)begin
	if(rst == 1)begin
		Conv4_count = 0;
		Conv4_times = 0;
	end
	else if(Conv4_weight_en == 1)begin
		//if(Conv4_count == 0)begin
		//	//$display("----------conv4_weight is being transmitted----------");
		//end	
		for(i=0;i<64;i++)begin
			in_weight[i] = Conv4_kernel[i*384+(Conv4_count/9)+(Conv4_times/55)*384*64+(Conv4_times%55)*7][8-(Conv4_count%9)];
		end
		Conv4_count = Conv4_count +1;
		if(Conv4_times% 55== 54)begin
			if(Conv4_count == 54)begin
				#(`CYCLE)
				Conv4_count = 0;
				Conv4_weight_en = 0;
				weight_en = 0;
				Conv4_times = Conv4_times + 1;
			end		
		end	
		if(Conv4_count == 63)begin
			#(`CYCLE)
			Conv4_count = 0;
			Conv4_weight_en = 0;
			weight_en = 0;
			Conv4_times = Conv4_times + 1;
		end
	end
end
//========CONV5 weight =====
int Conv5_count;
int Conv5_times;
always@(negedge clk)begin
	if(rst == 1)begin
		Conv5_count = 0;
		Conv5_times = 0;
	end
	else if(Conv5_weight_en == 1)begin
		if(Conv5_count == 0)begin
			//$display("----------conv5_weight is being transmitted----------");
		end	
		for(i=0;i<64;i++)begin
			in_weight[i] = Conv5_kernel[i*256+(Conv5_count/9)+(Conv5_times/37)*256*64+(Conv5_times%37)*7][8-(Conv5_count%9)];
		end
		Conv5_count = Conv5_count +1;
		if(Conv5_times% 37== 36)begin
			if(Conv5_count == 36)begin
				#(`CYCLE)
				Conv5_count = 0;
				Conv5_weight_en = 0;
				weight_en = 0;
				Conv5_times = Conv5_times + 1;
			end	
		end		
		if(Conv5_count == 63)begin
			#(`CYCLE)
			Conv5_count = 0;
			Conv5_weight_en = 0;
			weight_en = 0;
			Conv5_times = Conv5_times + 1;
		end
	end
end
//========FC1 weight =======
int FC1_count;
int FC1_times;
always@(negedge clk)begin
	if(rst == 1)begin
		FC1_count = 0;
		FC1_times = 0;
	end
	else if(FC1_weight_en == 1)begin
		//if(FC1_count == 0)begin
			//$display("----------FC1_weight is being transmitted----------");
		//end
		for(i=0;i<64;i++)begin
			in_weight[i] = FC1_weight[((FC1_times/144)*64)+i][((FC1_times%144)*64)+63-FC1_count];
		end
		FC1_count = FC1_count +1;
		if(FC1_count == 64)begin
			#(`CYCLE)
			FC1_weight_en = 0;
			FC1_count = 0;
			weight_en = 0;		
			FC1_times = FC1_times+1;
		end
	end
end
//========FC2 weight =======
int FC2_count;
int FC2_times;
always@(negedge clk)begin
	if(rst == 1)begin
		FC2_count = 0;
		FC2_times = 0;
	end
	else if(FC2_weight_en == 1)begin
		if(FC2_count == 0)begin
			//$display("----------FC2_weight is being transmitted----------");
		end
		for(i=0;i<64;i++)begin
			in_weight[i] = FC2_weight[((FC2_times/64)*64)+i][((FC2_times%64)*64)+63-FC2_count];
		end
		FC2_count = FC2_count +1;
		if(FC2_count == 64)begin
			#(`CYCLE)
			FC2_weight_en = 0;
			FC2_count = 0;
			weight_en = 0;		
			FC2_times = FC2_times+1;
		end		
	end
end
//========FC3 weight =======
int FC3_count;
int FC3_times;
always@(negedge clk)begin
	if(rst == 1)begin
		FC3_count = 0;
		FC3_times = 0;
	end
	else if(FC3_weight_en == 1)begin
		if(FC3_count == 0)begin
			//$display("----------FC3_weight is being transmitted----------");
		end
		if(FC3_times >= 960)begin
			for(i=0;i<40;i++)begin
				in_weight[i] = FC3_weight[((FC3_times/64)*64)+i][((FC3_times%64)*64)+63-FC3_count];
			end
		end	
		if(FC3_times < 960)begin
			for(i=0;i<64;i++)begin
				in_weight[i] = FC3_weight[((FC3_times/64)*64)+i][((FC3_times%64)*64)+63-FC3_count];
			end
		end
		FC3_count = FC3_count +1;
		if(FC3_count == 64)begin
			#(`CYCLE)
			FC3_weight_en = 0;
			FC3_count = 0;
			weight_en = 0;		
			FC3_times = FC3_times+1;
		end		
	end
end 
//====================================================
int conv1_fault_cnt, conv2_fault_cnt, conv3_fault_cnt, conv4_fault_cnt, conv5_fault_cnt, fc1_fault_cnt, fc2_fault_cnt, fc3_fault_cnt;
initial begin 
conv1_fault_cnt = 0;
conv2_fault_cnt = 0;
conv3_fault_cnt = 0;
conv4_fault_cnt = 0;
conv5_fault_cnt = 0;
fc1_fault_cnt = 0;
fc2_fault_cnt = 0;
fc3_fault_cnt = 0;
end
//===================存取conv1 output並做bias,relu,LRN maxpooling1=====================
int num_out;
reg signed[63:0]product;
reg signed[31:0]sim_conv1_output[(55*64)-1:0][54:0];
reg signed[31:0]sim_maxpool1[(27*64)-1:0][26:0];
int op_out_cnt;

reg signed[31:0] temp;
always @(negedge clk ) begin//存取conv1 output(55*55)
	if(rst == 1)begin
		op_out_cnt = 0;
		for(i=0;i<55*64;i++)begin
			for(j=0;j<55;j++)begin
				Conv1_output[i][j] = 32'd0;
			end
		end			
	end
	else if(RECEIVE_conv1_out == 1)begin
		//if(op_out_cnt == 0 && Conv2_times == 1)begin//初始歸0
		//	for(i=0;i<55*64;i++)begin
		//		for(j=0;j<55;j++)begin
		//			Conv1_output[i][j] = 32'd0;
		//		end
		//	end			
		//end		
		if(Conv1_times <=6)begin
			for(i=0;i<64;i++)begin
				if(op_out_cnt>=i && op_out_cnt<(55*55+i))begin
					Conv1_output[((op_out_cnt-i)/55)+(55*i)][(op_out_cnt-i)%55] = 
					Conv1_output[((op_out_cnt-i)/55)+(55*i)][(op_out_cnt-i)%55] + reg_psum[i];
				end
			end
		end
		
		op_out_cnt = op_out_cnt + 1;
		if(op_out_cnt == 55*55+63)begin
			#(`CYCLE)
			RECEIVE_conv1_out = 0;
			op_out_cnt = 0;
			if(Conv1_times == 6)begin//conv1 finish
				
				//---------------------sim------------------------------------
				for(i=0;i<55*64;i++)begin
					for(j=0;j<55;j++)begin
					sim_conv1_output[i][j] = 32'd0;	
					end
				end
				for(num_out=0;num_out<64;num_out++)begin//output 64group feature map
					for(k=0;k<3;k++)begin//6kernel
						for(r=0;r<55;r++)begin
							for(c=0;c<55;c++)begin
								product = 64'd0;
								for(i=0;i<11;i++)begin//kernel11x11
									for(j=0;j<11;j++)begin
										product = conv1_padding[(227*k)+(4*r)+i][(4*c)+j]*Conv1_kernel[k+(num_out*3)][(11*i)+j];//product;
										sim_conv1_output[(55*num_out)+r][c] = sim_conv1_output[(55*num_out)+r][c]+ $signed(product[55:24]);
									end
								end
							end
						end
					end
				end	
				//-------------------check-----------
				for(i=0;i<55*64;i++)begin
					for(j=0;j<55;j++)begin
						//$display("Conv1_output[%d][%d] = %d",i,j,Conv1_output[i][j]);	
						//$display("%d",sim_conv1_output[i][j]);	
						if(Conv1_output[i][j] !== sim_conv1_output[i][j])begin
							//$display("-----------//////////Conv1_output[%d][%d] error/////////-------",i,j);
							conv1_fault_cnt = conv1_fault_cnt+1;
						end
					end
				end
				$display("Conv1_output error number = %d",conv1_fault_cnt);
				
				//---------------------bias+relu------------------------------
				for(i=0;i<55*64;i++)begin//bias+relu
					for(j=0;j<55;j++)begin
						Conv1_output[i][j] = Conv1_output[i][j] + Bias_conv1[i/55];//bias
						if(Conv1_output[i][j] < 0)begin//relu
							Conv1_output[i][j] = 32'd0;
						end
					end
				end
				
				//-------------------maxpooling--------------------------------
				for(k=0;k<64;k++)begin	
					for(i=0;i<27;i++)begin//maxpooling(kernel=3;stride=2)
						for(j=0;j<27;j++)begin
							temp = Conv1_output[(k*55)+(i*2)][(j*2)];//stride=2
							for(r=0;r<3;r++)begin//kernel=3
								for(c=0;c<3;c++)begin
									if(Conv1_output[(k*55)+(i*2)+r][(j*2)+c]>temp)begin
										temp = Conv1_output[(k*55)+(i*2)+r][(j*2)+c];end
								end
							end
							Maxpool1_output[(27*k)+i][j]= temp;	
							//$display("Maxpool1_output[%d][%d] = %d",(27*k)+i,j,Maxpool1_output[(27*k)+i][j]);
						end
					end	
				end	
				//--------------sim maxpooling---------------
				for(i=0;i<(55*64);i++)begin//bias,ReLu
					for(j=0;j<55;j++)begin
						
						sim_conv1_output[i][j] = sim_conv1_output[i][j]+ Bias_conv1[i/55];
						//$display("sim_conv1_output[%d][%d] = %d",i,j,sim_conv1_output[i][j]);
						if(sim_conv1_output[i][j] <0)begin
							sim_conv1_output[i][j] = 0;	
						end		
					end
				end
				for(i=0;i<27*64;i++)begin//maxpooling(kernel=3;stride=2)
					for(j=0;j<27;j++)begin
						temp = sim_conv1_output[(i*2)][(j*2)];//stride=2
						for(r=0;r<3;r++)begin//kernel=3
							for(c=0;c<3;c++)begin
								if(sim_conv1_output[(i*2)+r][(j*2)+c]>temp)begin
									temp = sim_conv1_output[(i*2)+r][(j*2)+c];end
							end
						end
						sim_maxpool1[i][j]= temp;						
					end
				end	
				
				//------------------- "Input_conv2"--------------------
				for(i=0;i<24896;i++)begin
					for(j=0;j<50;j++)begin
						Input_conv2[i][j] = 32'd0;
					end
				end
				for(i=0;i<31*64;i++)begin//conv2 前置的padding後矩陣
					for(j=0;j<31;j++)begin
						conv2_padding[i][j] = 32'd0;
					end
				end	
				for(i=0;i<27*64;i++)begin
					for(j=0;j<27;j++)begin
						conv2_padding[(i/27)*31+(i%27)+2][j+2] = Maxpool1_output[i][j];
					end
				end
				for(k=0;k<64;k++)begin//img2col
					for(r=0;r<(31-4);r++)begin
						for(c=0;c<(31-4);c++)begin
							for(i=0;i<5;i++)begin
								for(j=0;j<5;j++)begin
									if(k%2 ==1)begin
										Input_conv2[(778*(k/2))+(27*r)+c+(5*i)+j][(5*i)+j] = conv2_padding[(31*k)+r+i][c+j];end
									if(k%2 ==0)begin	
										Input_conv2[(778*(k/2))+(27*r)+c+(5*i)+j+25][(5*i)+j+25] = conv2_padding[(31*k)+r+i][c+j];end
								end
							end
						end
					end
				end	
			end
		end	
	end
end
//========================mapping conv2 input===========================
int input_conv2_cnt;
always@(negedge clk)begin
	if(rst == 1)begin
		input_conv2_cnt = 0;
	end	
	else if(op_conv2_en == 1)begin//conv2輸入input
		for(i=0;i<64;i++)begin
			if(i<50)begin
				in_activation[i] = Input_conv2[input_conv2_cnt][i];
			end
			else begin
				in_activation[i] = 32'd0;
			end
		end
		input_conv2_cnt = input_conv2_cnt + 1;
		if(input_conv2_cnt%778 == 0)begin
			if(input_conv2_cnt == 24896)begin
				input_conv2_cnt = 0;
			end
			#(`CYCLE)
			op_conv2_en = 0;
		end
	end
end
//=======================存取conv2 output並做bias,relu,LRN maxpooling2=================
reg signed[31:0]sim_conv2_output[(27*192)-1:0][26:0];

always@(negedge clk)begin
	if(rst == 1)begin
		op_out_cnt = 0;
		for(i=0;i<27*192;i++)begin
			for(j=0;j<27;j++)begin
				Conv2_output[i][j] = 32'd0;
			end
		end		
	end
	else if(RECEIVE_conv2_out == 1)begin
		if(op_out_cnt ==0 && Conv2_times==1)begin//初始將output歸0
			for(i=0;i<27*192;i++)begin
				for(j=0;j<27;j++)begin
					Conv2_output[i][j] = 32'd0;
				end
			end
		end
		for(i=0;i<64;i++)begin
			if(op_out_cnt>=i && op_out_cnt<(27*27+i))begin
				Conv2_output[(op_out_cnt-i)/27+(27*i)+(((Conv2_times-1)/32)*27*64)][(op_out_cnt-i)%27] = 
				Conv2_output[(op_out_cnt-i)/27+(27*i)+(((Conv2_times-1)/32)*27*64)][(op_out_cnt-i)%27] + reg_psum[i];
			end
		end
		op_out_cnt = op_out_cnt +1;
		if(op_out_cnt == 27*27+63)begin
			#(`CYCLE)
			RECEIVE_conv2_out = 0;
			op_out_cnt = 0;
			if(Conv2_times == 96)begin//conv2 output finish
				//---------------------sim------------------------------------
				for(i=0;i<27*192;i++)begin
					for(j=0;j<27;j++)begin
					sim_conv2_output[i][j] = 32'd0;	
					end
				end
				for(num_out=0;num_out<192;num_out++)begin//output 192group feature map
					for(k=0;k<64;k++)begin//6kernel
						for(r=0;r<27;r++)begin
							for(c=0;c<27;c++)begin
								product = 64'd0;
								for(i=0;i<5;i++)begin//kernel11x11
									for(j=0;j<5;j++)begin
										product = conv2_padding[(31*k)+r+i][c+j]*Conv2_kernel[k+(num_out*64)][(5*i)+j];//product;
										sim_conv2_output[(27*num_out)+r][c] = sim_conv2_output[(27*num_out)+r][c]+ $signed(product[55:24]);
									end
								end
							end
						end
					end
				end	
				
				for(i=0;i<27*192;i++)begin
					for(j=0;j<27;j++)begin
						//$display("Conv2_output[%d][%d] =%d",i,j,Conv2_output[i][j]);
						//$display("sim_conv2_output[%d][%d] =%d",i,j,sim_conv2_output[i][j]);
						if(Conv2_output[i][j] !== sim_conv2_output[i][j])begin
							conv2_fault_cnt = conv2_fault_cnt+1;
						end
					end
				end
				$display("Conv2_output error number = %d",conv2_fault_cnt);
				//---------------bias+relu----------------
				for(i=0;i<27*192;i++)begin//bias+relu
					for(j=0;j<27;j++)begin
						Conv2_output[i][j] = Conv2_output[i][j] + Bias_conv2[i/27];//bias
						//$display("Conv2_output[%d][%d] =%d",i,j,Conv2_output[i][j]);
						if(Conv2_output[i][j] < 0)begin//relu
							Conv2_output[i][j] = 32'd0;
						end
					end
				end
				
				//--------------maxpooling---------------
				for(k=0;k<192;k++)begin
					for(i=0;i<13;i++)begin//maxpooling(kernel=3;stride=2)
						for(j=0;j<13;j++)begin
							temp = Conv2_output[(k*27)+(i*2)][(j*2)];//stride=2
							for(r=0;r<3;r++)begin//kernel=3
								for(c=0;c<3;c++)begin
									if(Conv2_output[(k*27)+(i*2)+r][(j*2)+c]>temp)begin
										temp = Conv2_output[(k*27)+(i*2)+r][(j*2)+c];end
								end
							end
							Maxpool2_output[(13*k)+i][j]= temp;						
						end
					end	
				end	
				//------------------- "Input_conv3"--------------------
				for(i=0;i<6468;i++)begin
					for(j=0;j<63;j++)begin
						Input_conv3[i][j] = 32'd0;
					end
				end
				for(i=0;i<15*192;i++)begin//conv3 前置的padding後矩陣
					for(j=0;j<15;j++)begin
						conv3_padding[i][j] = 32'd0;
					end
				end	
				for(i=0;i<13*192;i++)begin//padding=1
					for(j=0;j<13;j++)begin
						conv3_padding[(i/13)*15+(i%13)+1][j+1] = Maxpool2_output[i][j];
					end
				end
				//$display("conv3_padding");
				//for (int i = 0; i < 15*192; i++) begin
				//	for (int j = 0; j < 15; j++) begin
				//	// 使用 $write 或 $display 輸出矩陣元素
				//		
				//		$write("%0d ", conv3_padding[i][j]);
				//	end
				//// 換行
				//$display("");
				//end
				//-------------------img2col-------------------------
				for(k=0;k<192;k++)begin//img2col
					for(r=0;r<(15-2);r++)begin
						for(c=0;c<(15-2);c++)begin
							for(i=0;i<3;i++)begin
								for(j=0;j<3;j++)begin
									if(k<189)begin
										Input_conv3[(231*(k/7))+(13*r)+c+(3*i)+j+(6-(k%7))*9][(3*i)+j+(6-(k%7))*9] = conv3_padding[(15*k)+r+i][c+j];
									end
									if(k>=189)begin
										Input_conv3[(231*(k/7))+(13*r)+c+(3*i)+j+(2-(k%7))*9][(3*i)+j+(2-(k%7))*9] = conv3_padding[(15*k)+r+i][c+j];
									end
								end
							end
						end
					end
				end	
				//$display("Input_conv3");
				//for (int i = 0; i < 6468; i++) begin
				//	for (int j = 0; j < 63; j++) begin
				//	// 使用 $write 或 $display 輸出矩陣元素
				//		
				//		$write("%0d ", Input_conv3[i][j]);
				//	end
				//// 換行
				//$display("");
				//end
			end
		end
	end
end
//========================mapping conv3 input===========================
int input_conv3_cnt;
always@(negedge clk)begin
	if(rst == 1)begin
		input_conv3_cnt = 0;
	end	
	else if(op_conv3_en == 1)begin//conv3輸入input
		for(i=0;i<64;i++)begin
			if(i<63)begin
				in_activation[i] = Input_conv3[input_conv3_cnt][i];
			end
			else begin
				in_activation[i] = 32'd0;
			end
		end		
		input_conv3_cnt = input_conv3_cnt + 1;
		if(input_conv3_cnt%231 == 0)begin
			if(input_conv3_cnt == 6468)begin
				input_conv3_cnt = 0;
			end
			#(`CYCLE)
			op_conv3_en = 0;
		end
	end
end
//=======================存取conv3 output並做bias,relu
reg signed[31:0]	sim_conv3_output[(13*384)-1:0][12:0];

always@(negedge clk)begin
	if(rst == 1)begin
		op_out_cnt = 0;
		for(i=0;i<13*384;i++)begin
			for(j=0;j<13;j++)begin
				Conv3_output[i][j] = 32'd0;
			end
		end		
	end
	else if(RECEIVE_conv3_out == 1)begin
		if(op_out_cnt ==0 && Conv3_times==1)begin//初始將output歸0
			for(i=0;i<13*384;i++)begin
				for(j=0;j<13;j++)begin
					Conv3_output[i][j] = 32'd0;
				end
			end
		end
		for(i=0;i<64;i++)begin
			if(op_out_cnt>=i && op_out_cnt<(13*13+i))begin
				Conv3_output[(op_out_cnt-i)/13+(13*i)+(((Conv3_times-1)/28)*13*64)][(op_out_cnt-i)%13]=
				Conv3_output[(op_out_cnt-i)/13+(13*i)+(((Conv3_times-1)/28)*13*64)][(op_out_cnt-i)%13] + reg_psum[i];
			end
		end
		op_out_cnt = op_out_cnt +1;
		if(op_out_cnt == 13*13+63)begin
			#(`CYCLE)
			RECEIVE_conv3_out = 0;
			op_out_cnt = 0;
			if(Conv3_times == 168)begin//conv3 output finish
				//---------------------sim------------------------------------
				for(i=0;i<13*384;i++)begin
					for(j=0;j<13;j++)begin
					sim_conv3_output[i][j] = 32'd0;	
					end
				end
				for(num_out=0;num_out<384;num_out++)begin//output 192group feature map
					for(k=0;k<192;k++)begin//6kernel
						for(r=0;r<13;r++)begin
							for(c=0;c<13;c++)begin
								product = 64'd0;
								for(i=0;i<3;i++)begin//kernel11x11
									for(j=0;j<3;j++)begin
										product = conv3_padding[(15*k)+r+i][c+j]*Conv3_kernel[k+(num_out*192)][(3*i)+j];//product;
										sim_conv3_output[(13*num_out)+r][c] = sim_conv3_output[(13*num_out)+r][c]+ $signed(product[55:24]);
									end
								end
							end
						end
					end
				end	
				
				for(i=0;i<13*384;i++)begin
					for(j=0;j<13;j++)begin
						//$display("Conv3_output[%d][%d] =%d",i,j,Conv3_output[i][j]);
						//$display("sim_conv3_output[%d][%d] =%d",i,j,sim_conv3_output[i][j]);
						if(Conv3_output[i][j] != sim_conv3_output[i][j])begin
							conv3_fault_cnt = conv3_fault_cnt+1;
						end
					end
				end
				$display("Conv3_output error number = %d",conv3_fault_cnt);
				//---------------bias+relu----------------
				for(i=0;i<13*384;i++)begin//bias+relu
					for(j=0;j<13;j++)begin
						Conv3_output[i][j] = Conv3_output[i][j] + Bias_conv3[i/13];//bias
						//$display("Conv3_output[%d][%d] =%d",i,j,Conv3_output[i][j]);
						if(Conv3_output[i][j] < 0)begin//relu
							Conv3_output[i][j] = 32'd0;
						end
					end
				end
				//------------------- "Input_conv4"--------------------
				for(i=0;i<12705;i++)begin
					for(j=0;j<63;j++)begin
						Input_conv4[i][j] = 32'd0;
					end
				end
				for(i=0;i<15*384;i++)begin//conv4 前置的padding後矩陣
					for(j=0;j<15;j++)begin
						conv4_padding[i][j] = 32'd0;
					end
				end	
				for(i=0;i<13*384;i++)begin//padding=1
					for(j=0;j<13;j++)begin
						conv4_padding[((i/13)*15)+(i%13)+1][j+1] = Conv3_output[i][j];
					end
				end
				//$display("conv4_padding");
				//for (int i = 0; i < 15*384; i++) begin
				//	for (int j = 0; j < 15; j++) begin
				//		$write("%0d ", conv4_padding[i][j]);
				//	end
				//// 換行
				//$display("");
				//end
				//-------------------img2col-------------------------
				for(k=0;k<384;k++)begin//img2col
					for(r=0;r<(15-2);r++)begin
						for(c=0;c<(15-2);c++)begin
							for(i=0;i<3;i++)begin
								for(j=0;j<3;j++)begin
									if(k<378)begin
										Input_conv4[(231*(k/7))+(13*r)+c+(3*i)+j+(6-(k%7))*9][(3*i)+j+(6-(k%7))*9] = conv4_padding[(15*k)+r+i][c+j];
									end
									if(k>=378)begin
										Input_conv4[(231*(k/7))+(13*r)+c+(3*i)+j+(5-(k%7))*9][(3*i)+j+(5-(k%7))*9] = conv4_padding[(15*k)+r+i][c+j];
									end
								end
							end
						end
					end
				end	
				//$display("Input_conv4");
				//for (int i = 0; i < 12705; i++) begin
				//	for (int j = 0; j < 63; j++) begin
				//		$write("%0d ", Input_conv4[i][j]);
				//	end
				//// 換行
				//$display("");
				//end
			end
		end
	end
end
//========================mapping conv4 input===========================
int input_conv4_cnt;
always@(negedge clk)begin
	if(rst == 1)begin
		input_conv4_cnt = 0;
	end	
	else if(op_conv4_en == 1)begin//conv4輸入input
		for(i=0;i<64;i++)begin
			if(i<63)begin
				in_activation[i] = Input_conv4[input_conv4_cnt][i];
				//$display("in_activation[%d] = Input_conv4[%d][%d] ",i,input_conv4_cnt,i);
				//$display("%d = %d",in_activation[i] ,Input_conv4[input_conv4_cnt][i]);
			end
			//$display("");
			else begin
				in_activation[i] = 32'd0;
			end
		end		
		//$display("input_conv4_cnt = %d",input_conv4_cnt);
		input_conv4_cnt = input_conv4_cnt + 1;
		if(input_conv4_cnt%231 == 0)begin
			if(input_conv4_cnt == 12705)begin
				input_conv4_cnt = 0;
			end
			#(`CYCLE)
			op_conv4_en = 0;
		end
	end
end
//=======================存取conv4 output並做bias,relu=================
reg signed[31:0]	sim_conv4_output[(13*256)-1:0][12:0];

always@(negedge clk)begin
	if(rst == 1)begin
		op_out_cnt = 0;
		for(i=0;i<13*256;i++)begin
			for(j=0;j<13;j++)begin
				Conv4_output[i][j] = 32'd0;
			end
		end		
	end
	else if(RECEIVE_conv4_out == 1)begin
		//if(op_out_cnt ==0 && Conv4_times==1)begin//初始將output歸0
		//	for(i=0;i<13*256;i++)begin
		//		for(j=0;j<13;j++)begin
		//			Conv4_output[i][j] = 32'd0;
		//		end
		//	end
		//end
		//$display("Conv4_output");
		for(i=0;i<64;i++)begin
			if(op_out_cnt>=i && op_out_cnt<(13*13+i))begin
				Conv4_output[(op_out_cnt-i)/13+(13*i)+(((Conv4_times-1)/55)*13*64)][(op_out_cnt-i)%13] = 
				Conv4_output[(op_out_cnt-i)/13+(13*i)+(((Conv4_times-1)/55)*13*64)][(op_out_cnt-i)%13] + reg_psum[i];
				//$write("%0d ", reg_psum[i]);
			end
		end
		//$display("");
		op_out_cnt = op_out_cnt +1;
		if(op_out_cnt == 13*13+63)begin
			#(`CYCLE)
			RECEIVE_conv4_out = 0;
			op_out_cnt = 0;
			if(Conv4_times == 220)begin//conv4 output finish
				//---------------------sim------------------------------------
				for(i=0;i<13*256;i++)begin
					for(j=0;j<13;j++)begin
					sim_conv4_output[i][j] = 32'd0;	
					end
				end
				for(num_out=0;num_out<256;num_out++)begin//output 192group feature map
					for(k=0;k<384;k++)begin//384kernel
						for(r=0;r<13;r++)begin
							for(c=0;c<13;c++)begin
								product = 64'd0;
								for(i=0;i<3;i++)begin//kernel11x11
									for(j=0;j<3;j++)begin
										product = conv4_padding[(15*k)+r+i][c+j]*Conv4_kernel[k+(num_out*384)][(3*i)+j];//product;
										sim_conv4_output[(13*num_out)+r][c] = sim_conv4_output[(13*num_out)+r][c]+ $signed(product[55:24]);
									end
								end
							end
						end
					end
				end	
				
				for(i=0;i<13*256;i++)begin
					for(j=0;j<13;j++)begin
						//$display("Conv4_output[%d][%d] =%d",i,j,Conv4_output[i][j]);
						//$display("sim_conv4_output[%d][%d] =%d",i,j,sim_conv4_output[i][j]);
						if(Conv4_output[i][j] !== sim_conv4_output[i][j])begin
							conv4_fault_cnt = conv4_fault_cnt+1;
						end
					end
				end
				$display("Conv4_output error number = %d",conv4_fault_cnt);
				//---------------bias+relu----------------
				for(i=0;i<13*256;i++)begin//bias+relu
					for(j=0;j<13;j++)begin
						Conv4_output[i][j] = Conv4_output[i][j] + Bias_conv4[i/13];//bias
						//$display("Conv4_output[%d][%d] =%d",i,j,Conv4_output[i][j]);
						if(Conv4_output[i][j] < 0)begin//relu
							Conv4_output[i][j] = 32'd0;
						end
					end
				end	
				//------------------- "Input_conv5"--------------------
				for(i=0;i<8547;i++)begin
					for(j=0;j<63;j++)begin
						Input_conv5[i][j] = 32'd0;
					end
				end
				for(i=0;i<15*256;i++)begin//conv4 前置的padding後矩陣
					for(j=0;j<15;j++)begin
						conv5_padding[i][j] = 32'd0;
					end
				end	
				for(i=0;i<13*256;i++)begin//padding=1
					for(j=0;j<13;j++)begin
						conv5_padding[(i/13)*15+(i%13)+1][j+1] = Conv4_output[i][j];
					end
				end
				//-------------------img2col-------------------------
				for(k=0;k<256;k++)begin//img2col
					for(r=0;r<(15-2);r++)begin
						for(c=0;c<(15-2);c++)begin
							for(i=0;i<3;i++)begin
								for(j=0;j<3;j++)begin
									if(k<252)begin
										Input_conv5[(231*(k/7))+(13*r)+c+(3*i)+j+(6-(k%7))*9][(3*i)+j+(6-(k%7))*9] = conv5_padding[(15*k)+r+i][c+j];
									end
									if(k>=252)begin
										Input_conv5[(231*(k/7))+(13*r)+c+(3*i)+j+(3-(k%7))*9][(3*i)+j+(3-(k%7))*9] = conv5_padding[(15*k)+r+i][c+j];
									end
								end
							end
						end
					end
				end	
			end
		end	
	end
end	
//========================mapping conv5 input===========================
int input_conv5_cnt;
always@(negedge clk)begin
	if(rst == 1)begin
		input_conv5_cnt = 0;
	end	
	else if(op_conv5_en == 1)begin//conv4輸入input
		for(i=0;i<64;i++)begin
			if(i<63)begin
				in_activation[i] = Input_conv5[input_conv5_cnt][i];
			end
			else begin
				in_activation[i] = 32'd0;
			end
		end		
		input_conv5_cnt = input_conv5_cnt + 1;
		if(input_conv5_cnt%231 == 0)begin
			if(input_conv5_cnt == 8547)begin
				input_conv5_cnt = 0;
			end
			#(`CYCLE)
			op_conv5_en = 0;
		end
	end
end
//=======================存取conv5 output並做bias,relu,maxpooling3,dropout1=================
reg signed[31:0]	sim_conv5_output[(13*256)-1:0][12:0];

always@(negedge clk)begin
	if(rst == 1)begin
		op_out_cnt = 0;
		for(i=0;i<13*256;i++)begin
			for(j=0;j<13;j++)begin
				Conv5_output[i][j] = 32'd0;
			end
		end		
	end
	else if(RECEIVE_conv5_out == 1)begin
		if(op_out_cnt ==0 && Conv5_times==1)begin//初始將output歸0
			for(i=0;i<13*256;i++)begin
				for(j=0;j<13;j++)begin
					Conv5_output[i][j] = 32'd0;
				end
			end
		end
		for(i=0;i<64;i++)begin
			if(op_out_cnt>=i && op_out_cnt<(13*13+i))begin
				Conv5_output[(op_out_cnt-i)/13+(13*i)+(((Conv5_times-1)/37)*13*64)][(op_out_cnt-i)%13] =
				Conv5_output[(op_out_cnt-i)/13+(13*i)+(((Conv5_times-1)/37)*13*64)][(op_out_cnt-i)%13] + reg_psum[i];
			end
		end
		op_out_cnt = op_out_cnt +1;
		if(op_out_cnt == 13*13+63)begin
			#(`CYCLE)
			RECEIVE_conv5_out = 0;
			op_out_cnt = 0;
			if(Conv5_times == 148)begin//conv5 output finish
				//---------------------sim------------------------------------
				for(i=0;i<13*256;i++)begin
					for(j=0;j<13;j++)begin
					sim_conv5_output[i][j] = 32'd0;	
					end
				end
				for(num_out=0;num_out<256;num_out++)begin//output 192group feature map
					for(k=0;k<256;k++)begin//6kernel
						for(r=0;r<13;r++)begin
							for(c=0;c<13;c++)begin
								product = 64'd0;
								for(i=0;i<3;i++)begin//kernel11x11
									for(j=0;j<3;j++)begin
										product = conv5_padding[(15*k)+r+i][c+j]*Conv5_kernel[k+(num_out*256)][(3*i)+j];//product;
										sim_conv5_output[(13*num_out)+r][c] = sim_conv5_output[(13*num_out)+r][c]+ $signed(product[55:24]);
									end
								end
							end
						end
					end
				end	
				
				for(i=0;i<13*256;i++)begin
					for(j=0;j<13;j++)begin
						//$display("Conv5_output[%d][%d] =%d",i,j,Conv5_output[i][j]);
						//$display("sim_conv5_output[%d][%d] =%d",i,j,sim_conv5_output[i][j]);
						if(Conv5_output[i][j] !== sim_conv5_output[i][j])begin
							conv5_fault_cnt = conv5_fault_cnt+1;
						end
					end
				end
				$display("Conv5_output error number = %d",conv5_fault_cnt);
				//---------------bias+relu----------------------
				for(i=0;i<13*256;i++)begin//bias+relu
					for(j=0;j<13;j++)begin
						Conv5_output[i][j] = Conv5_output[i][j] + Bias_conv5[i/13];//bias
						//$display("Conv5_output[%d][%d] =%d",i,j,Conv5_output[i][j]);
						if(Conv5_output[i][j] < 0)begin//relu
							Conv5_output[i][j] = 32'd0;
						end
					end
				end 
				//----------------maxpooling--------------------
				for(k=0;k<256;k++)begin
					for(i=0;i<6;i++)begin//maxpooling(kernel=3;stride=2)
						for(j=0;j<6;j++)begin
							temp = Conv5_output[(k*13)+(i*2)][(j*2)];//stride=2
							for(r=0;r<3;r++)begin//kernel=3
								for(c=0;c<3;c++)begin
									if(Conv5_output[(k*13)+(i*2)+r][(j*2)+c]>temp)begin
										temp = Conv5_output[(k*13)+(i*2)+r][(j*2)+c];end
								end
							end
							Maxpool3_output[(k*6)+i][j]= temp ;//dropout 0.5
						end
					end
				end
				//------------------- "Input_FC1"--------------------
				for(i=0;i<9216;i++)begin 
					for(j=0;j<64;j++)begin
						Input_FC1[i][j] = 32'd0;
					end
				end
				//---------------------img2col--------
				for(i=0;i<6*256;i++)begin
					for(j=0;j<6;j++)begin
						Input_FC1[(6*i)+j][((6*i)+j)%64] = Maxpool3_output[i][j];
						
					end
				end				
							
			end
		end	
	end
end
//======================mapping FC1 input======================
int input_FC1_cnt;
always@(negedge clk)begin
	if(rst == 1)begin
		input_FC1_cnt = 0;
	end	
	else if(op_FC1_en == 1)begin//conv4輸入input
		for(i=0;i<64;i++)begin
				in_activation[i] = Input_FC1[input_FC1_cnt][i];
		end		
		input_FC1_cnt = input_FC1_cnt + 1;
		if(input_FC1_cnt%64 == 0)begin
			if(input_FC1_cnt == 9216)begin
				input_FC1_cnt = 0;
			end
			#(`CYCLE)
			op_FC1_en = 0;
		end
	end
end
//=====================存取FC1 output,bias,ReLU,dropout2================================
reg signed[31:0] sim_FC1_output[4095:0];

always @(negedge clk ) begin
	if(rst == 1)begin
	op_out_cnt = 0;
	for(i=0;i<4096;i++)begin
		FC1_output[i] = 32'd0;
	end
	end
	else if(RECEIVE_FC1_out == 1)begin
		if(op_out_cnt == 0 && FC1_times == 0)begin//初始FC1_output先歸0
			for(i=0;i<4096;i++)begin
				FC1_output[i] = 32'd0;
			end
		end
		//$display("FC1_output[%d]+reg_psum[%d] = %d+%d",op_out_cnt+(32*FC1_times),op_out_cnt,FC1_output[op_out_cnt+(32*FC1_times)],reg_psum[op_out_cnt]);
		FC1_output[op_out_cnt+(64*((FC1_times-1)/144))] = 
		FC1_output[op_out_cnt+(64*((FC1_times-1)/144))]+reg_psum[op_out_cnt];
		op_out_cnt = op_out_cnt+1;
		if(op_out_cnt == 64)begin
			#(`CYCLE)
			RECEIVE_FC1_out = 0;
			op_out_cnt = 0;
			if(FC1_times == 9216)begin//fc1 output finish
				//-----sim FC1----------
					
				for(i=0;i<4096;i++)begin
					product = 64'd0;
					sim_FC1_output[i] = 32'd0;
					for(j=0;j<9216;j++)begin
						product = Maxpool3_output[j/6][j%6]*FC1_weight[i][j];
						sim_FC1_output[i] = sim_FC1_output[i] + $signed(product[55:24]);
					end
				end
				
					for(i=0;i<4096;i++)begin
						//$display("FC1_output[%d] =%d",i,FC1_output[i]);
						//$display("sim_FC1_output[%d] =%d",i,sim_FC1_output[i]);
						if(FC1_output[i] !== sim_FC1_output[i])begin
							fc1_fault_cnt = fc1_fault_cnt +1;
						end
					end
				
				$display("FC1_output error number = %d",fc1_fault_cnt);
				//---------------bias+relu+dropout---------------- 
				for(i=0;i<4096;i++)begin//bias+relu
					FC1_output[i] = (FC1_output[i] + Bias_fc1[i]) ;//bias+dropout
					if(FC1_output[i] < 0)begin//relu
						FC1_output[i] = 32'd0;
					end
				end
				//------------------- "Input_FC2"--------------------
				for(i=0;i<4096;i++)begin 
					for(j=0;j<64;j++)begin
						Input_FC2[i][j] = 32'd0;
					end
				end
				//---------------------img2col--------
				for(i=0;i<4096;i++)begin
					Input_FC2[i][i%64] = FC1_output[i];
				end	
			end
		end
	end
end	
//======================mapping FC2 input======================
int input_FC2_cnt;
always@(negedge clk)begin
	if(rst == 1)begin
		input_FC2_cnt = 0;
	end	
	else if(op_FC2_en == 1)begin//conv4輸入input
		for(i=0;i<64;i++)begin
				in_activation[i] = Input_FC2[input_FC2_cnt][i];
		end		
		input_FC2_cnt = input_FC2_cnt + 1;
		if(input_FC2_cnt%64 == 0)begin
			if(input_FC2_cnt == 4096)begin
				input_FC2_cnt = 0;
			end
			#(`CYCLE)
			op_FC2_en = 0;
		end
	end
end
//==================存取FC2 output,bias,ReLU===============
reg signed[31:0] sim_FC2_output[4095:0];

always @(negedge clk ) begin
	if(rst == 1)begin
	op_out_cnt = 0;
	for(i=0;i<4096;i++)begin
		FC2_output[i] = 32'd0;
	end
	end
	else if(RECEIVE_FC2_out == 1)begin
		if(op_out_cnt == 0 && FC2_times == 0)begin//初始FC2_output先歸0
			for(i=0;i<4096;i++)begin
				FC2_output[i] = 32'd0;
			end
		end
		
		FC2_output[op_out_cnt+(64*((FC2_times-1)/64))] = 
		FC2_output[op_out_cnt+(64*((FC2_times-1)/64))]+reg_psum[op_out_cnt];
		op_out_cnt = op_out_cnt+1;
		if(op_out_cnt == 64)begin
			#(`CYCLE)
			RECEIVE_FC2_out = 0;
			op_out_cnt = 0;
			if(FC2_times == 4096)begin//fc2 output finish
				//-----sim FC2----------
					
				for(i=0;i<4096;i++)begin
					product = 64'd0;
					sim_FC2_output[i] = 32'd0;
					for(j=0;j<4096;j++)begin
						product = FC1_output[j]*FC2_weight[i][j];
						sim_FC2_output[i] = sim_FC2_output[i] + $signed(product[55:24]);
					end
				end
				
				for(i=0;i<4096;i++)begin
					//$display("FC2_output[%d] =%d",i,FC2_output[i]);
					//$display("sim_FC2_output[%d] =%d",i,sim_FC2_output[i]);
					if(FC2_output[i] !== sim_FC2_output[i])begin
						fc2_fault_cnt = fc2_fault_cnt +1;
					end
				end
				
				$display("FC2_output error number = %d",fc2_fault_cnt);
				//---------------bias+relu----------------
				for(i=0;i<4096;i++)begin//bias+relu
					FC2_output[i] = FC2_output[i] + Bias_fc2[i];//bias
					if(FC2_output[i] < 0)begin//relu
						FC2_output[i] = 32'd0;
					end
				end	
				//------------------- "Input_FC3"--------------------
				for(i=0;i<4096;i++)begin 
					for(j=0;j<64;j++)begin
						Input_FC3[i][j] = 32'd0;
					end
				end
				//---------------------img2col--------
				for(i=0;i<4096;i++)begin
					Input_FC3[i][i%64] = FC2_output[i];
				end	
			end
		end
	end
end	
//======================mapping FC3 input======================
int input_FC3_cnt;
always@(negedge clk)begin
	if(rst == 1)begin
		input_FC3_cnt = 0;
	end	
	else if(op_FC3_en == 1)begin//fc3輸入input
		for(i=0;i<64;i++)begin
				in_activation[i] = Input_FC3[input_FC3_cnt][i];
		end		
		input_FC3_cnt = input_FC3_cnt + 1;
		if(input_FC3_cnt%64 == 0)begin
			if(input_FC3_cnt == 4096)begin
				input_FC3_cnt = 0;
			end
			#(`CYCLE)
			op_FC3_en = 0;
		end
	end
end 
//==================存取FC3 output,bias===============
reg signed[31:0]sim_FC3_output[999:0];

always @(negedge clk ) begin
	if(rst == 1)begin
	op_out_cnt = 0;
	for(i=0;i<1000;i++)begin
		FC3_output[i] = 32'd0;
	end
	end
	else if(RECEIVE_FC3_out == 1)begin
		if(op_out_cnt == 0 && FC3_times == 0)begin//初始FC2_output先歸0
			for(i=0;i<1000;i++)begin
				FC3_output[i] = 32'd0;
			end
		end
		
		FC3_output[op_out_cnt+(64*((FC3_times-1)/64))] = 
		FC3_output[op_out_cnt+(64*((FC3_times-1)/64))]+reg_psum[op_out_cnt];
		op_out_cnt = op_out_cnt+1;
		if(FC3_times <=960)begin
			if(op_out_cnt == 64)begin
				#(`CYCLE)
				RECEIVE_FC3_out = 0;
				op_out_cnt = 0;
			end
		end
		if(FC3_times >960)begin
			if(op_out_cnt == 40)begin
				#(`CYCLE)
				RECEIVE_FC3_out = 0;
				op_out_cnt = 0;
				if(FC3_times == 1024)begin//finish
					//-----sim FC2----------
					for(i=0;i<1000;i++)begin
						product = 64'd0;
						sim_FC3_output[i] = 32'd0;
						for(j=0;j<4096;j++)begin
							product = FC2_output[j]*FC3_weight[i][j];
							sim_FC3_output[i] = sim_FC3_output[i] + $signed(product[55:24]);
						end
					end
					
					for(i=0;i<1000;i++)begin
						//$display("FC3_output[%d] =%d",i,FC3_output[i]);
						//$display("sim_FC3_output[%d] =%d",i,sim_FC3_output[i]);
						if(FC3_output[i] !== sim_FC3_output[i])begin
							fc3_fault_cnt = fc3_fault_cnt +1;
						end
					end
					
					$display("FC3_output error number = %d",fc3_fault_cnt);
				//---------------bias----------------
					for(i=0;i<1000;i++)begin//bias
						FC3_output[i] = FC3_output[i] + Bias_fc3[i];//bias
						
					end	
				end
			end
		end
	end
end	
//==================predict======================  
//task PREDICT ;begin
//		
//		champion = 0;
//		champion_value = 0;
//		
//		for(i=0;i<1000;i++)begin
//			if(FC3_output[i] > champion_value)begin
//				champion_value = FC3_output[i];
//				champion = i;
//			end
//		end		
//		
//	end	
//endtask

int temp_value;
int temp_index;
task PREDICT;begin
    
        for (j = 0; j < 5; j++) begin
            champion[j] = 0;
            champion_value[j] = 0;
        end
 
        for (i = 0; i < 1000; i++) begin
            if (FC3_output[i] > champion_value[4]) begin
                champion_value[4] = FC3_output[i];
                champion[4] = i;
				
                for (j = 4; j > 0 && champion_value[j] > champion_value[j-1]; j = j - 1) begin
                    temp_value = champion_value[j];
                    champion_value[j] = champion_value[j-1];
                    champion_value[j-1] = temp_value;

                    temp_index = champion[j];
                    champion[j] = champion[j-1];
                    champion[j-1] = temp_index;
                end
            end
        end
		for(k=0;k<5;k++)begin
			$write("champion %d",champion[k]);
		end
		$display("");
    end
endtask

always begin
   #5 clk = ~clk;
end
int cnt_clk;
initial begin
cnt_clk = 0;
end

//always@(negedge clk)begin
//	
//	cnt_clk = cnt_clk + 1 ;
//	if(cnt_clk == `End_CYCLE)begin
//	$display("SOMETHING WAS WRONG");
//	$display("FINISH");
//	$finish;
//	end
//end
//initial begin
//	$fsdbDumpfile("tb_SA64_.fsdb");
//	$fsdbDumpvars;
//	$fsdbDumpMDA;
//end   

endmodule