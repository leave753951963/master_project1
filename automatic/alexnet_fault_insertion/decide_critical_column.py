#!/usr/bin/python
# -*- coding: utf-8 -*-
#叫出txt，比對critical程度
#重新寫sa64(減掉修復完的)
import os
import numpy as np
import random_fault_SA64 as write
import random
import sys
sys.path.append('/home/wzc/master_project/alexnet_pth/')
import decimal_to_binary_32bit as trans
import itertools

sub_dir  = "/home/wzc/master_project/alexnet_verilog/fault_insertion/"
sub_file = "protected_SA64_random_fault.v" #file name

module_name = "SA64"#module name
PE_number = 64 #PE number
threshold1 = 1.5*100 
threshold2 = 0.5*100
max_repair_num =127
#-----------fault information
FAULT_coordinate_file = "sa_fault_info/fault_inject_coordinate.txt"
stuckat_fault_file = "sa_fault_info/proposed_stuckat_fault.txt"
FAULT_stuckat_fault = "sa_fault_info/stuckat_fault.txt"#原始sa fault
protected_fault_num_file = "sa_fault_info/protected_fault_num.txt"
stuckat_fault_path = os.path.join(sub_dir,stuckat_fault_file)
FAULT_stuckat_fault_path =  os.path.join(sub_dir,FAULT_stuckat_fault)
#----------------------------------------------------------------------
columns = {}
bias_of_column = {}
sorted_dict = {}

fault_coordinate = np.zeros
for i in range(PE_number):
    column_name = f'column{i}'
    file_name = f'output{i}.txt'
    file_path = os.path.join(sub_dir,'bias_output/',file_name)
    with open(file_path, "r") as fh:
        columns[column_name] = [line.strip() for line in fh]
    #if i <=5:
    #    columns[column_name] = columns[column_name][500:]#column 前6的前500筆資料無用
        
    selected_column_values  = [int(value) for value in columns[column_name]if value.strip()] 
    
    count_greater_than_threshold1 = sum(1 for value in selected_column_values if value > threshold1 )#bias error>10
    count_greater_than_threshold2 = sum(1 for value in selected_column_values if value < threshold2 )
    
    count_nagetive = sum(1 for value in selected_column_values if value < 0)#<0
    #print(len(selected_column_values))
    bias_of_column[i] =(count_greater_than_threshold1+count_greater_than_threshold2+count_nagetive*10)/ len(selected_column_values)#probability

sorted_dict = {k: v for k, v in sorted(bias_of_column.items(), key=lambda item: -item[1])} #
sorted_dict = {key: value for key, value in sorted_dict.items() if value != 0}
print("sorted_dict = ",sorted_dict)
keys_list = list(sorted_dict.keys())#sorted critical column
print("keys_list = ",keys_list) 
coordinate_path = os.path.join(sub_dir,FAULT_coordinate_file)
with open(coordinate_path, "r") as fr:
    content = fr.read()
fault_coordinate = eval(content) 
with open(FAULT_stuckat_fault_path, "r") as fr:
    sa_value = fr.readlines()
    sa_value = [line.rstrip('\n') for line in sa_value]

deleted_count = 0
temp2 = []
temp=[]
for j in range(len(keys_list)):
    if deleted_count >= int(max_repair_num):
        print("---break---")
        break
    to_be_repaired_column = keys_list[j]
    print("to_be_repaired_column = ",to_be_repaired_column)
    for k in range(len(fault_coordinate)):#將符合repaired column的座標刪除
        
        if fault_coordinate[k][1] != to_be_repaired_column:
            temp.append(fault_coordinate[k])
            temp2.append(sa_value[k])
        else:  
            if deleted_count < int(max_repair_num):
                deleted_count += 1
                #print("deleted_count = ",deleted_count)
            else:
                temp.append(fault_coordinate[k])
                temp2.append(sa_value[k])
    fault_coordinate = temp
    sa_value = temp2
    #print("fault coordinate = ",fault_coordinate)
    #print("fault coordinate = ",len(fault_coordinate))      
    temp = []
    temp2 = []
print("fault coordinate = ",fault_coordinate)
print("fault coordinate = ",len(fault_coordinate))    
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
spare = 0#不要有spare的output 
write.write_SA(PE_number,fault_coordinate,target_path,stuckat_fault_path,module_name,spare)