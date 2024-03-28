#!/usr/bin/python
# -*- coding: utf-8 -*-
import os
import random
import sys
sys.path.append('/home/wzc/lenet/LeNet-5-MNIST-PyTorch/')
import decimal_to_binary as trans
## single PE組成的32*32SA，不引入PE
top_path = os.getcwd()
sub_file = "SA32.v" #file name
module_name = "SA32"#module name
sub_dir  = "/home/wzc/verilog/systolic_array"#file path
PE_number = 32 #PE number
#---------------------對COLUMN的OUTPUT做BIAS ERROR
column_fault_num = 0
#---------------------對PE INJECT FAULT
faultPE_per_column = 3
fault_column = 11
#---------------------
target_path = os.path.join(sub_dir,sub_file) 
#------create file------------
touch_file = ("touch "+sub_file)

if not os.path.exists(target_path):
    os.chdir(sub_dir)
    os.system(str(touch_file))

#------生成random 1~32-------- 
def generate_sorted_unique_list(start, end, n):#變數範圍、n個fault
    # 確保 n 不超過範圍
    n = min(n, end - start + 1)
    # 生成不重複的隨機變數
    random_values = random.sample(range(start, end + 1), n)
    # 排序
    random_values.sort()
    return random_values
#-----------------------------

#-----write module&declaration
num_column = PE_number//2
with open(target_path, "w") as fh:
    fh.write('''`include "/home/wzc/verilog/systolic_array/PE.v"\n''')
    fh.write("module "+module_name+"(rst, clk, weight_en")
    for c in range(PE_number):#0~31
        fh.write(", in_weight_"+str(c))
        fh.write(", in_psum_"+str(c))
    for r in range(PE_number):
        fh.write(", in_activation_"+str(r))
    for c in range(PE_number):#0~31    
        fh.write(", out_psum_"+str(c))
    fh.write(",spare_out );\n\n")
    fh.write("input weight_en;\n") 
    fh.write("input clk,rst;\n") 
    
    for c in range(PE_number):
        fh.write("input signed[15:0]   in_weight_"+str(c)+";\n")
        fh.write("input signed[15:0]   in_psum_"+str(c)+";\n")
    for r in range(PE_number):
        fh.write("input signed[15:0]   in_activation_"+str(r)+";\n")

    for c in range(PE_number):
        fh.write("output signed[15:0]   out_psum_"+str(c)+";\n")
    for c in range(PE_number):        
        fh.write("wire signed[31:0] attempt_"+str(c)+";\n")
        
    for r in range(PE_number): #0~31
        for c in range(PE_number): #0~31
                fh.write("wire signed[15:0]    reg_activation_"+str(r)+"_"+str(c)+";\n")

    for r in range(PE_number): #row0~31
        for c in range(PE_number): #column0~31
                fh.write("wire signed[15:0]    reg_weight_"+str(r)+"_"+str(c)+";\n")
                fh.write("wire signed[15:0]    reg_psum_"+str(r)+"_"+str(c)+";\n")
#----PE fault-----更改錯誤PE下面一顆的INPUT
    PE_fault_list = generate_sorted_unique_list(0, 31, faultPE_per_column)               
    for n in range(PE_number):
        if n in PE_fault_list:
            fh.write("wire signed[15:0]    fault_reg_psum_"+str(n)+"_"+str(fault_column)+";\n")
        else:
            pass
    sa1_list = ["0000000000000001","0000000000000010","0000000000000100","0000000000001000","0000000000010000","0000000000100000","0000000001000000","0000000010000000","0000000100000000","0000001000000000","0000010000000000","0000100000000000","0001000000000000","0010000000000000","0100000000000000","1000000000000000"]
    for n in range(PE_number):
        if n in PE_fault_list:
            sa1_value = random.choice(sa1_list)
            print(sa1_value)
            fh.write("assign fault_reg_psum_"+str(n)+"_"+str(fault_column)+" = reg_psum_"+str(n)+"_"+str(fault_column)+" | 16'b"+sa1_value+" ;\n")
        



### instance module

    for r in range(PE_number): #row0~31
        for c in range(PE_number): #column0~31
            if(c == 0):
                if ((c == fault_column) and ((r-1) in PE_fault_list)):#---if it is the fault PE's next PE ，it's input psum will be different
                    if(r == PE_number-1):#activation is input/no outputweight
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(in_activation_"+str(r)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(fault_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    else:#activation is input
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(in_activation_"+str(r)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(fault_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                else:    
                    if(r == 0):#weight,psum,activation are input
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(in_activation_0), .weight_in(in_weight_0), .partial_sum_in(in_psum_0), .reg_activation(reg_activation_0_0), .reg_weight(reg_weight_0_0), .reg_partial_sum(reg_psum_0_0), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    elif(r == PE_number-1):#activation is input/no outputweight
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(in_activation_"+str(r)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    else:#activation is input
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(in_activation_"+str(r)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
            elif(c == PE_number-1):
                if ((c == fault_column) and ((r-1) in PE_fault_list)):#---if it is the fault PE's next PE ，it's input psum will be different
                    if(r == PE_number-1):#no output weight activation 
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(fault_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    else:# no output ,activation    
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(fault_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")

                else:
                    if(r == 0):#weight,psum are input/no output activation 
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(in_weight_"+str(c)+"), .partial_sum_in(in_psum_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    elif(r == PE_number-1):#no output weight activation 
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    else:# no output ,activation    
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
            else:
                if ((c == fault_column) and ((r-1) in PE_fault_list)):#---if it is the fault PE's next PE ，it's input psum will be different
                    if(r == PE_number-1):# no outputweight 
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(fault_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    else:
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(fault_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
   
                else:
                    if(r == 0):#weight,psum are input
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(in_weight_"+str(c)+"), .partial_sum_in(in_psum_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    elif(r == PE_number-1):# no outputweight 
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    else:
                        fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
   
    #------額外替代column

    for r in range(PE_number): #row0~31
                fh.write("wire signed[15:0]    spare_reg_weight_"+str(r)+"_"+str(fault_column)+";\n")
                fh.write("wire signed[15:0]    spare_reg_psum_"+str(r)+"_"+str(fault_column)+";\n") 
    fh.write("output signed[15:0]   spare_out;\n")  
    fh.write("assign spare_out = spare_reg_psum_31_"+str(fault_column)+";\n")    
    for r in range(PE_number): #row0~31
        if(fault_column == 0):   
            if(r == 0):#weight,psum,activation are input
                fh.write("PE X"+str(r)+"_"+str(fault_column)+"( .activation_in(in_activation_0), .weight_in(in_weight_0), .partial_sum_in(in_psum_0), .reg_weight(spare_reg_weight_0_0), .reg_partial_sum(spare_reg_psum_0_0), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
            elif(r == PE_number-1):#activation is input/no outputweight
                fh.write("PE X"+str(r)+"_"+str(fault_column)+"( .activation_in(in_activation_"+str(r)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(fault_column)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(fault_column)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(fault_column)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
            else:#activation is input
                fh.write("PE X"+str(r)+"_"+str(fault_column)+"( .activation_in(in_activation_"+str(r)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(fault_column)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(fault_column)+"), .reg_weight(spare_reg_weight_"+str(r)+"_"+str(fault_column)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(fault_column)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
        elif(fault_column == PE_number-1):
            if(r == 0):#weight,psum are input/no output activation 
                fh.write("PE X"+str(r)+"_"+str(fault_column)+"( .activation_in(reg_activation_"+str(r)+"_"+str(fault_column-1)+"), .weight_in(in_weight_"+str(fault_column)+"), .partial_sum_in(in_psum_"+str(fault_column)+"), .reg_weight(spare_reg_weight_"+str(r)+"_"+str(fault_column)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(fault_column)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
            elif(r == PE_number-1):#no output weight activation 
                fh.write("PE X"+str(r)+"_"+str(fault_column)+"( .activation_in(reg_activation_"+str(r)+"_"+str(fault_column-1)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(fault_column)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(fault_column)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(fault_column)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
            else:# no output ,activation    
                fh.write("PE X"+str(r)+"_"+str(fault_column)+"( .activation_in(reg_activation_"+str(r)+"_"+str(fault_column-1)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(fault_column)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(fault_column)+"), .reg_weight(spare_reg_weight_"+str(r)+"_"+str(fault_column)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(fault_column)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
        else:
            if(r == 0):#weight,psum are input
                fh.write("PE X"+str(r)+"_"+str(fault_column)+"( .activation_in(reg_activation_"+str(r)+"_"+str(fault_column-1)+"), .weight_in(in_weight_"+str(fault_column)+"), .partial_sum_in(in_psum_"+str(fault_column)+"), .reg_weight(spare_reg_weight_"+str(r)+"_"+str(fault_column)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(fault_column)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
            elif(r == PE_number-1):# no outputweight 
                fh.write("PE X"+str(r)+"_"+str(fault_column)+"( .activation_in(reg_activation_"+str(r)+"_"+str(fault_column-1)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(fault_column)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(fault_column)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(fault_column)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
            else:
                fh.write("PE X"+str(r)+"_"+str(fault_column)+"( .activation_in(reg_activation_"+str(r)+"_"+str(fault_column-1)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(fault_column)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(fault_column)+"), .reg_weight(spare_reg_weight_"+str(r)+"_"+str(fault_column)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(fault_column)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
           


     #############
    
    column_fault_list = generate_sorted_unique_list(0, 31, column_fault_num)
    
    for n in range(PE_number):
        if n in column_fault_list:
            random_value_dec = random.uniform(0.5, 1.5)
            
            random_value_Q610 = trans.float_to_fixed_point(random_value_dec)
            fh.write("assign attempt_"+str(n)+" =  reg_psum_31_"+str(n)+" *$signed(16'b"+random_value_Q610+")"+";\n")
            fh.write("assign out_psum_"+str(n)+" = $signed(attempt_"+str(n)+"[25:10]);\n")
        else:
            fh.write("assign out_psum_"+str(n)+" =  reg_psum_31_"+str(n)+";\n")
        
    
    
    
    fh.write("endmodule")    
        
    print("finish")    
