#!/usr/bin/python
# -*- coding: utf-8 -*-
#針對單一指定column做random插錯
#針對column的output做bias error插錯
import os
import random
import sys


## single PE組成的32*32SA，不引入PE22
top_path = os.getcwd()
sub_file = "32bit_SA64.v" #file name

module_name = "SA64"#module name
sub_dir  = "/home/wzc/master_project/alexnet_verilog"#file path
PE_number = 64 #PE number

#---------------------
target_path = os.path.join(sub_dir,sub_file) 
#------create file------------
touch_file = ("touch "+sub_file)


if not os.path.exists(target_path):
    os.chdir(sub_dir)
    os.system(str(touch_file))


#-----write module&declaration
num_column = PE_number//2
with open(target_path, "w") as fh:
    fh.write('''`include "/home/wzc/master_project/verilog/systolic_array/32bit_PE.v"\n''')
    fh.write("module "+module_name+"(rst, clk, weight_en")
    for c in range(PE_number):#
        fh.write(", in_weight_"+str(c))
        fh.write(", in_psum_"+str(c))
    for r in range(PE_number):
        fh.write(", in_activation_"+str(r))
    for c in range(PE_number):#
        if (c== (PE_number-1)):
            fh.write(", out_psum_"+str(c)+");\n")
        else:
            fh.write(", out_psum_"+str(c))
    #fh.write(",spare_out );\n\n")
    fh.write("input weight_en;\n") 
    fh.write("input clk,rst;\n") 
    
    for c in range(PE_number):
        fh.write("input signed[31:0]   in_weight_"+str(c)+";\n")
        fh.write("input signed[31:0]   in_psum_"+str(c)+";\n")
    for r in range(PE_number):
        fh.write("input signed[31:0]   in_activation_"+str(r)+";\n")

    for c in range(PE_number):
        fh.write("output signed[31:0]   out_psum_"+str(c)+";\n")
    
    for r in range(PE_number): 
        for c in range(PE_number): #
                fh.write("wire signed[31:0]    reg_activation_"+str(r)+"_"+str(c)+";\n")

    for r in range(PE_number): #
        for c in range(PE_number): #
                fh.write("wire signed[31:0]    reg_weight_"+str(r)+"_"+str(c)+";\n")
                fh.write("wire signed[31:0]    reg_psum_"+str(r)+"_"+str(c)+";\n")

### instance module

    for r in range(PE_number): #row0~31
        for c in range(PE_number): #column0~31
            if(c == 0):
                if(r == 0):#weight,psum,activation are input
                    fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(in_activation_0), .weight_in(in_weight_0), .partial_sum_in(in_psum_0), .reg_activation(reg_activation_0_0), .reg_weight(reg_weight_0_0), .reg_partial_sum(reg_psum_0_0), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                elif(r == PE_number-1):#activation is input/no outputweight
                    fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(in_activation_"+str(r)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                else:#activation is input
                    fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(in_activation_"+str(r)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
            elif(c == PE_number-1):
                if(r == 0):#weight,psum are input/no output activation 
                    fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(in_weight_"+str(c)+"), .partial_sum_in(in_psum_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                elif(r == PE_number-1):#no output weight activation 
                    fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                else:# no output ,activation    
                    fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
            else:
                if(r == 0):#weight,psum are input
                    fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(in_weight_"+str(c)+"), .partial_sum_in(in_psum_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                elif(r == PE_number-1):# no outputweight 
                    fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                else:
                    fh.write("PE U"+str(r)+"_"+str(c)+"( .activation_in(reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(reg_activation_"+str(r)+"_"+str(c)+"), .reg_weight(reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")

    for i in range(PE_number):
        fh.write("assign out_psum_"+str(i)+" = "+"reg_psum_63_"+str(i)+";\n")
    fh.write("endmodule")    
        
    print("finish")    
