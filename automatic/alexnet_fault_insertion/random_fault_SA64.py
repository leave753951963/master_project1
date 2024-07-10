#!/usr/bin/python
# -*- coding: utf-8 -*-
#針對整個SA根據fault PE rate做random 插錯
import os
import random
import sys
sys.path.append('/home/wzc/master_project/alexnet_pth/')
import decimal_to_binary_32bit as trans
import itertools

def write_SA(PE_number,FAULT_coordinate,target_path,stuckat_fault_path,module_name,spare):
##-----write module&declaration
    num_column = PE_number//2
    with open(target_path, "w") as fh:
        fh.write('''`include "/home/wzc/master_project/verilog/systolic_array/32bit_PE.v"\n''')
        #fh.write('''`include "/home/wzc/master_project/verilog/approx_pe/PE_approx_SA.v"\n''')
        fh.write("module "+module_name+"(rst, clk, weight_en")
        for c in range(PE_number):#0~31
            fh.write(", in_weight_"+str(c))
            fh.write(", in_psum_"+str(c))
        fh.write("\n")    
        for r in range(PE_number):
            fh.write(", in_activation_"+str(r))
        fh.write("\n")     
        for c in range(PE_number):#0~31    
            fh.write(", out_psum_"+str(c))
        fh.write("\n") 
        if(spare == 1):
            for c in range(PE_number):#0~31    
                fh.write(", spare_out_psum_"+str(c))    
        fh.write(");\n\n")
        fh.write("input weight_en;\n") 
        fh.write("input clk,rst;\n") 
        
        for c in range(PE_number):
            fh.write("input signed[31:0]   in_weight_"+str(c)+";\n")
            fh.write("input signed[31:0]   in_psum_"+str(c)+";\n")
        for r in range(PE_number):
            fh.write("input signed[31:0]   in_activation_"+str(r)+";\n")
    
        for c in range(PE_number):
            fh.write("output signed[31:0]   out_psum_"+str(c)+";\n")
        for c in range(PE_number):        
            fh.write("wire signed[63:0] attempt_"+str(c)+";\n")
            
        for r in range(PE_number): #0~31
            for c in range(PE_number): #0~31
                    fh.write("wire signed[31:0]    reg_activation_"+str(r)+"_"+str(c)+";\n")
    
        for r in range(PE_number): #row0~31
            for c in range(PE_number): #column0~31
                    fh.write("wire signed[31:0]    reg_weight_"+str(r)+"_"+str(c)+";\n")
                    fh.write("wire signed[31:0]    reg_psum_"+str(r)+"_"+str(c)+";\n")
        for n in range(PE_number):
            fh.write("assign out_psum_"+str(n)+" =  reg_psum_63_"+str(n)+";\n")            
#讀取PE fault stuck at fault    
        print(FAULT_coordinate)
        for n in range(PE_number):
            for j in range(PE_number):
                if ((n,j) in FAULT_coordinate):
                    fh.write("wire signed[31:0]    fault_reg_psum_"+str(n)+"_"+str(j)+";\n")
                else:
                    pass
        with open(stuckat_fault_path, "r") as fr:
            sa_value = fr.readlines()
            sa_value = [line.rstrip('\n') for line in sa_value]
            k = 0
            for (n,j)in FAULT_coordinate:
                fh.write("assign fault_reg_psum_"+str(n)+"_"+str(j)+" = reg_psum_"+str(n)+"_"+str(j)+sa_value[k]+";\n")
                k = k+1
            
    
    ### instance module
    
        for r in range(PE_number): #row0~31
            for c in range(PE_number): #column0~31
                if(c == 0):
                    if ((r-1,c) in FAULT_coordinate):#---if it is the fault PE's next PE ，it's input psum will be different
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
                    if ((r-1,c) in FAULT_coordinate):#---if it is the fault PE's next PE ，it's input psum will be different
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
                    if ((r-1,c) in FAULT_coordinate):#---if it is the fault PE's next PE ，it's input psum will be different
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
        if(spare == 0):
            fh.write("endmodule")
def spare_SA(PE_number,target_path):    
    num_column = PE_number//2
    with open(target_path, "a") as fh:
       #------額外替代column(使用approx)
        for r in range(PE_number): #0~31
            for c in range(PE_number): #0~31
                    fh.write("wire signed[31:0]    spare_reg_activation_"+str(r)+"_"+str(c)+";\n")
    
        for r in range(PE_number): #row0~31
            for c in range(PE_number): #column0~31
                    fh.write("wire signed[31:0]    spare_reg_weight_"+str(r)+"_"+str(c)+";\n")
                    fh.write("wire signed[31:0]    spare_reg_psum_"+str(r)+"_"+str(c)+";\n")            
        for c in range(PE_number):
            fh.write("output signed[31:0]   spare_out_psum_"+str(c)+";\n")
        for n in range(PE_number):
            fh.write("assign spare_out_psum_"+str(n)+" =  spare_reg_psum_63_"+str(n)+";\n")       
        
        for r in range(PE_number): #row0~31
            for c in range(PE_number): #column0~31
                if(c == 0):       
                    if(r == 0):#weight,psum,activation are input
                        fh.write("PE X"+str(r)+"_"+str(c)+"( .activation_in(in_activation_0), .weight_in(in_weight_0), .partial_sum_in(in_psum_0), .reg_activation(spare_reg_activation_0_0), .reg_weight(spare_reg_weight_0_0), .reg_partial_sum(spare_reg_psum_0_0), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    elif(r == PE_number-1):#activation is input/no outputweight
                        fh.write("PE X"+str(r)+"_"+str(c)+"( .activation_in(in_activation_"+str(r)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(spare_reg_activation_"+str(r)+"_"+str(c)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    else:#activation is input
                        fh.write("PE X"+str(r)+"_"+str(c)+"( .activation_in(in_activation_"+str(r)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(spare_reg_activation_"+str(r)+"_"+str(c)+"), .reg_weight(spare_reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                elif(c == PE_number-1):
                    if(r == 0):#weight,psum are input/no output activation 
                        fh.write("PE X"+str(r)+"_"+str(c)+"( .activation_in(spare_reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(in_weight_"+str(c)+"), .partial_sum_in(in_psum_"+str(c)+"), .reg_weight(spare_reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    elif(r == PE_number-1):#no output weight activation 
                        fh.write("PE X"+str(r)+"_"+str(c)+"( .activation_in(spare_reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    else:# no output ,activation    
                        fh.write("PE X"+str(r)+"_"+str(c)+"( .activation_in(spare_reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_weight(spare_reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                else:
                    if(r == 0):#weight,psum are input
                        fh.write("PE X"+str(r)+"_"+str(c)+"( .activation_in(spare_reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(in_weight_"+str(c)+"), .partial_sum_in(in_psum_"+str(c)+"), .reg_activation(spare_reg_activation_"+str(r)+"_"+str(c)+"), .reg_weight(spare_reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    elif(r == PE_number-1):# no outputweight 
                        fh.write("PE X"+str(r)+"_"+str(c)+"( .activation_in(spare_reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(spare_reg_activation_"+str(r)+"_"+str(c)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
                    else:
                        fh.write("PE X"+str(r)+"_"+str(c)+"( .activation_in(spare_reg_activation_"+str(r)+"_"+str(c-1)+"), .weight_in(spare_reg_weight_"+str(r-1)+"_"+str(c)+"), .partial_sum_in(spare_reg_psum_"+str(r-1)+"_"+str(c)+"), .reg_activation(spare_reg_activation_"+str(r)+"_"+str(c)+"), .reg_weight(spare_reg_weight_"+str(r)+"_"+str(c)+"), .reg_partial_sum(spare_reg_psum_"+str(r)+"_"+str(c)+"), .clk(clk), .rst(rst), .weight_en(weight_en));\n")
        
        
        fh.write("endmodule")    
            
        print("finish")    
#==================================================================================================================
if __name__ == "__main__":
    ## single PE組成的32*32SA，不引入SA22
    top_path = os.getcwd()
    sub_file = "SA64_random_fault.v" #file name
    stuckat_fault_file = "sa_fault_info/stuckat_fault.txt"
    fault_coordinate_file = "sa_fault_info/fault_inject_coordinate.txt"
    module_name = "SA64"#module name
    sub_dir  = "/home/wzc/master_project/alexnet_verilog/fault_insertion/"#file path

    PE_number = 64 #PE number#
    #---------------------
    target_path = os.path.join(sub_dir,sub_file) 
    stuckat_fault_path = os.path.join(sub_dir,stuckat_fault_file)
    #---------------------對PE INJECT FAULT
    
    if len(sys.argv) > 1:
        NUM_FAULTY_PE = int(sys.argv[1])
    else:
        NUM_FAULTY_PE = 184
    
    print("NUM_FAULTY_PE = ",NUM_FAULTY_PE)    
    coordinate_path = os.path.join(sub_dir,fault_coordinate_file) 
    random_list = list(itertools.product(range(0,PE_number-1),range(0,PE_number-1))) #產生隨機座標
    FAULT_coordinate = random.sample(random_list,NUM_FAULTY_PE)
    FAULT_coordinate = sorted(FAULT_coordinate, key=lambda coord: coord[0], reverse=True)
    #print(FAULT_coordinate)
    with open(coordinate_path, "w") as fr: 
        fr.write(str(FAULT_coordinate))
        
    #----PE fault-----更改錯誤PE下面一顆的INPUT--------------

    sa_list = ["| 32'b00000000000000000000000000000001","| 32'b00000000000000000000000000000010","| 32'b00000000000000000000000000000100","| 32'b00000000000000000000000000001000","| 32'b00000000000000000000000000010000","| 32'b00000000000000000000000000100000","| 32'b00000000000000000000000001000000","| 32'b00000000000000000000000010000000"
    ,"| 32'b00000000000000000000000100000000","| 32'b00000000000000000000001000000000","| 32'b00000000000000000000010000000000","| 32'b00000000000000000000100000000000"
    ,"| 32'b00000000000000000001000000000000","| 32'b00000000000000000010000000000000","| 32'b00000000000000000100000000000000","| 32'b00000000000000001000000000000000"
    ,"| 32'b00000000000000010000000000000000","| 32'b00000000000000100000000000000000","| 32'b00000000000001000000000000000000","| 32'b00000000000010000000000000000000"
    ,"| 32'b00000000000100000000000000000000","| 32'b00000000001000000000000000000000","| 32'b00000000010000000000000000000000","| 32'b00000000100000000000000000000000"
    ,"| 32'b00000001000000000000000000000000"
    ,"& 32'b11111111111111111111111111111110"
    ,"& 32'b11111111111111111111111111111101"
    ,"& 32'b11111111111111111111111111111011"
    ,"& 32'b11111111111111111111111111110111"
    ,"& 32'b11111111111111111111111111101111"
    ,"& 32'b11111111111111111111111111011111"
    ,"& 32'b11111111111111111111111110111111"
    ,"& 32'b11111111111111111111111101111111"
    ,"& 32'b11111111111111111111111011111111"
    ,"& 32'b11111111111111111111110111111111"
    ,"& 32'b11111111111111111111101111111111"
    ,"& 32'b11111111111111111111011111111111"
    ,"& 32'b11111111111111111110111111111111"
    ,"& 32'b11111111111111111101111111111111"
    ,"& 32'b11111111111111111011111111111111"
    ,"& 32'b11111111111111110111111111111111"
    ,"& 32'b11111111111111101111111111111111"
    ,"& 32'b11111111111111011111111111111111"
    ,"& 32'b11111111111110111111111111111111"
    ,"& 32'b11111111111101111111111111111111"
    ,"& 32'b11111111111011111111111111111111"
    ,"& 32'b11111111110111111111111111111111"
    ,"& 32'b11111111101111111111111111111111"
    ,"& 32'b11111111011111111111111111111111"
    ,"& 32'b11111110111111111111111111111111"
    ,"& 32'b11111101111111111111111111111111"]
    with open(stuckat_fault_path,"w") as fn:
        for j in range(PE_number):
            for n in range(PE_number):
                if ((n,(PE_number-1-j)) in FAULT_coordinate):
                    sa_value = random.choice(sa_list)#random stuck at fault
                    fn.write(str(sa_value)+"\n")
                    
  
    #------create file------------
    touch_file = ("touch "+sub_file)
    
    if not os.path.exists(target_path):
        os.chdir(sub_dir)
        os.system(str(touch_file))
    spare = 1    
    write_SA(PE_number,FAULT_coordinate,target_path,stuckat_fault_path,module_name,spare)
    spare_SA(PE_number,target_path)

