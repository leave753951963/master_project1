#!/usr/bin/python
# -*- coding: utf-8 -*-
#叫出txt，比對critical程度
#重新寫sa32(減掉修復完的)
import os
import numpy as np
import random_fault_SA as write
import random
import sys
sys.path.append('/home/wzc/lenet/LeNet-5-MNIST-PyTorch/') 
import decimal_to_binary as trans
import itertools
sub_dir  = "/home/wzc/master_project/verilog/"
sub_file = "systolic_array/FSA_SA32_random_fault_protected.v" #file name

module_name = "SA32"#module name
PE_number = 32 #PE number
max_repair_num =64

#-----------fault information
FAULT_coordinate_file = "systolic_array/fault_inject_coordinate.txt"
#protected_fault_num_file = "protected_fault_num.txt"
stuckat_fault_file = "systolic_array/sa_fault_info/FSA_proposed_stuckat_fault.txt"
FAULT_stuckat_fault = "systolic_array/sa_fault_info/stuckat_fault.txt"#原始sa fault
stuckat_fault_path = os.path.join(sub_dir,stuckat_fault_file)
FAULT_stuckat_fault_path =  os.path.join(sub_dir,FAULT_stuckat_fault)
#-------------------------------------------------------------
fault_coordinate = np.zeros

coordinate_path = os.path.join(sub_dir,FAULT_coordinate_file)
with open(coordinate_path, "r") as fr:
    content = fr.read()
fault_coordinate = eval(content)
with open(FAULT_stuckat_fault_path, "r") as fr:
    sa_value = fr.readlines()
    sa_value = [line.rstrip('\n') for line in sa_value]
    
print(fault_coordinate)
deleted_count = 0
temp2 = []
temp=[]
for j in range(PE_number):
    if deleted_count >= int(max_repair_num):
        print("---break---")
        break
    to_be_repaired_column = j
    print("to_be_repaired_column = ",to_be_repaired_column)
    for k in range(len(fault_coordinate)):#將符合repaired column的座標刪除
        
        if fault_coordinate[(len(fault_coordinate)-1)-k][1] != to_be_repaired_column:
            #print((len(fault_coordinate)-1)-k)
            temp.append(fault_coordinate[(len(fault_coordinate)-1)-k])
            temp2.append(sa_value[(len(fault_coordinate)-1)-k])
        else:  
            if deleted_count < int(max_repair_num):
                deleted_count += 1
                #print("fault_coordinate[",len(fault_coordinate)-1-k,"][1]= ",fault_coordinate[len(fault_coordinate)-1-k][1])
                #print("deleted_count = ",deleted_count)
            else:
                temp.append(fault_coordinate[(len(fault_coordinate)-1)-k])
                temp2.append(sa_value[(len(fault_coordinate)-1)-k])      
    fault_coordinate = temp
    sa_value = temp2
    #print("fault coordinate = ",fault_coordinate)
    #print("fault coordinate = ",len(fault_coordinate))      
    temp = []
    temp2 = []
print("fault coordinate = ",fault_coordinate)    
#with open(protected_fault_num_file,'a')as fn:#寫入保護數量
#    fn.write(str(deleted_count)+"\n")
with open(stuckat_fault_path,'w')as fk:#寫入保護數量
    for n in range(len(sa_value)):
        fk.write(str(sa_value[n])+"\n")     
#=============================寫保護過後的SA====================

top_path = os.getcwd()
#---------------------
target_path = os.path.join(sub_dir,sub_file) 
#------create file------------
touch_file = ("touch "+sub_file)

if not os.path.exists(target_path):
    os.chdir(sub_dir)
    os.system(str(touch_file))
 
write.write_SA(PE_number,fault_coordinate,target_path,stuckat_fault_path,module_name)