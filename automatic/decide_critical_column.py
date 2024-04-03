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
sub_file = "systolic_array/SA32_protected_fault.v" #file name
module_name = "SA32"#module name
PE_number = 32 #PE number
threshold = 10*100
sub_dir  = "/home/wzc/master_project/verilog/"
FAULT_coordinate_file = "systolic_array/fault_inject_coordinate.txt"
columns = {}
bias_of_column = {}
bias10_probability = np.zeros(32)
fault_coordinate = np.zeros
for i in range(32):
    column_name = f'column{i}'
    file_name = f'output{i}.txt'
    file_path = os.path.join(sub_dir,file_name)
    with open(file_path, "r") as fh:
        columns[column_name] = [line.strip() for line in fh]
    selected_column_values = [int(value) for value in columns[column_name]]
    count_greater_than_threshold = sum(1 for value in selected_column_values if value > threshold)#bias error>10
    count_nagetive = sum(1 for value in selected_column_values if value < 0)#<0
    
    bias_of_column[i] = (count_greater_than_threshold+count_nagetive)/ len(selected_column_values)#probability
    
sorted_dict = {k: v for k, v in sorted(bias_of_column.items(), key=lambda item: -item[1])}   #排序完嚴重程度的dict 
sorted_dict = {key: value for key, value in sorted_dict.items() if value != 0}
#print("sorted_dict = ",sorted_dict)
keys_list = list(sorted_dict.keys())#sorted critical column
#print("keys_list = ",keys_list)
coordinate_path = os.path.join(sub_dir,FAULT_coordinate_file)
with open(coordinate_path, "r") as fr:
    content = fr.read()
fault_coordinate = eval(content)


deleted_count = 0
temp=[]
for j in range(len(keys_list)):
    if deleted_count >= 64:
        #print("---break---")
        break
    to_be_repaired_column = keys_list[j]
    #print("to_be_repaired_column = ",to_be_repaired_column)
    for k in range(len(fault_coordinate)):#將符合repaired column的座標刪除
        
        if deleted_count >= 64:
            #print("---break---")
            break
        
        if fault_coordinate[k][1] != to_be_repaired_column:
            temp.append(fault_coordinate[k])
        else:    
            deleted_count += 1
            #print("deleted_count = ",deleted_count)
    fault_coordinate = temp
    temp = []
#=============================寫保護過後的SA====================
#print(fault_coordinate)
## single PE組成的32*32SA，不引入SA22
top_path = os.getcwd()


#---------------------
target_path = os.path.join(sub_dir,sub_file) 
#------create file------------
touch_file = ("touch "+sub_file)
#FAULT_coordinate = fault_coordinate.tolist()
if not os.path.exists(target_path):
    os.chdir(sub_dir)
    os.system(str(touch_file))

write.write_SA(PE_number,fault_coordinate,target_path,module_name)