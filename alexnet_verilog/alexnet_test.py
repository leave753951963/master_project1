import os
import random
from PIL import Image
import numpy as np
import torchvision.transforms as trns
#import decimal_to_binary as trans_dec_binary
import torch
import torch.nn as nn
from typing import Any


weight_pth = "/home/wzc/master_project/alexnet_pth/alexnet-owt-4df8aa71.pth"
image_path = '/home/wzc/master_project/alexnet-pytorch-master/alexnet_data_in/maltese.jpeg'
class AlexNet(nn.Module):
    def __init__(self, num_classes: int = 1000) -> None:
        super(AlexNet, self).__init__()

        self.features = nn.Sequential(
            nn.Conv2d(3, 64, (11, 11), (4, 4), (2, 2)),
            nn.ReLU(True),
            nn.MaxPool2d((3, 3), (2, 2)),

            nn.Conv2d(64, 192, (5, 5), (1, 1), (2, 2)),
            nn.ReLU(True),
            nn.MaxPool2d((3, 3), (2, 2)),

            nn.Conv2d(192, 384, (3, 3), (1, 1), (1, 1)),
            nn.ReLU(True),
            nn.Conv2d(384, 256, (3, 3), (1, 1), (1, 1)),
            nn.ReLU(True),
            nn.Conv2d(256, 256, (3, 3), (1, 1), (1, 1)),
            nn.ReLU(True),
            nn.MaxPool2d((3, 3), (2, 2)),
        )

        self.avgpool = nn.AdaptiveAvgPool2d((6, 6))

        self.classifier = nn.Sequential(
            nn.Dropout(0.5),
            nn.Linear(256 * 6 * 6, 4096),
            nn.ReLU(True),
            nn.Dropout(0.5),
            nn.Linear(4096, 4096),
            nn.ReLU(True),
            nn.Linear(4096, num_classes),
        )

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        return self._forward_impl(x)

    def _forward_impl(self, x: torch.Tensor) -> torch.Tensor:
        out = self.features(x)
        out = self.avgpool(out)
        out = torch.flatten(out, 1)
        out = self.classifier(out)

        return out

def alexnet(**kwargs: Any) -> AlexNet:
    model = AlexNet(**kwargs)
    return model

def load_weights(model, weight_file):
    state_dict = torch.load(weight_file)
    model.load_state_dict(state_dict)

def get_model_weights(model):
    weights_dict = {}
    for name, param in model.named_parameters():
        weights_dict[name] = param.data.clone()
    return weights_dict

model = AlexNet(num_classes=1000)

load_weights(model, weight_pth)

model_weights_info = get_model_weights(model)
#print(model_weights_info.shape)
print(type(model_weights_info))

keys = list(model_weights_info.keys())
#print(len(keys))
#print(model_weights_info[keys[0]].shape)
model_weights_info = {key: value.numpy() for key, value in model_weights_info.items()}
#------------input--------------
image = Image.open(image_path).convert("RGB")
transforms = trns.Compose([trns.Resize((224, 224)), trns.ToTensor(), trns.Normalize(
    mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])])
image_tensor = transforms(image)
print(image_tensor.shape)
#-----------weight-------------

Conv1_kernel = model_weights_info[keys[0]]
print('Conv1_kernel',Conv1_kernel.shape)
Bias_conv1 = model_weights_info[keys[1]]
Conv2_kernel = model_weights_info[keys[2]]
print('Conv2_kernel',Conv2_kernel.shape)
Bias_conv2 = model_weights_info[keys[3]]
Conv3_kernel = model_weights_info[keys[4]]
print('Conv3_kernel',Conv3_kernel.shape)
Bias_conv3 = model_weights_info[keys[5]]
Conv4_kernel = model_weights_info[keys[6]]
print('Conv4_kernel',Conv4_kernel.shape)
Bias_conv4 = model_weights_info[keys[7]]
Conv5_kernel = model_weights_info[keys[8]]
print('Conv5_kernel',Conv5_kernel.shape)
Bias_conv5 = model_weights_info[keys[9]]
FC1_weight = model_weights_info[keys[10]]
print('FC1_weight',FC1_weight.shape)
Bias_fc1 = model_weights_info[keys[11]]
FC2_weight = model_weights_info[keys[12]]
print('FC2_weight',FC2_weight.shape)
Bias_fc2 = model_weights_info[keys[13]]
FC3_weight = model_weights_info[keys[14]]
print('FC3_weight',FC3_weight.shape)
Bias_fc3 = model_weights_info[keys[15]]
print("Bias_fc3 :",Bias_fc3.shape)   
#---------------------------------
conv1_padding = np.zeros((227*3, 227))
for k in range(3):
    for i in range(224):
        for j in range(224):
            conv1_padding[k*227+i+2,j+2] = image_tensor[k,i,j]
            
#---conv1------
        
sim_conv1_output = np.zeros((55*64, 55)) 

for num_out in range(64):
    for k in range(3):
        for r in range(55):
            for c in range(55):
                for i in range(11):
                    for j in range(11):
                        sim_conv1_output[(55*num_out)+r, c] = sim_conv1_output[(55*num_out)+r, c] + (conv1_padding[(227*k)+(4*r)+i, (4*c)+j] * Conv1_kernel[num_out,k,i,j])

#---sim maxpooling
for i in range(55*64):
    for j in range(55):
        sim_conv1_output[i,j] = sim_conv1_output[i,j]+ Bias_conv1[i//55]
        if (sim_conv1_output[i,j] <0):
            sim_conv1_output[i,j] = 0
      
sim_maxpool1 = np.zeros((27*64, 27))
for k in range(64):
    for i in range(27):
        for j in range(27):
            temp = sim_conv1_output[(k*55)+(i*2),(j*2)]
            for r in range(3):
                for c in range(3):
                    if(sim_conv1_output[(k*55)+(i*2)+r,(j*2)+c]>temp):
                        temp = sim_conv1_output[(k*55)+(i*2)+r,(j*2)+c]
            sim_maxpool1[(27*k)+i,j] = temp						

#--- "Input_conv2"
print('conv2')
conv2_padding = np.zeros((31*64, 31))

for i in range(27*64):
    for j in range(27):
        conv2_padding[(i//27)*31+(i%27)+2,j+2] = sim_maxpool1[i,j]   

sim_conv2_output = np.zeros((27*192, 27))

for num_out in range(192):
    for k in range(64):
        for r in range(27):
            for c in range(27):
                for i in range(5):
                    for j in range(5):
                        sim_conv2_output[(27*num_out)+r,c] = sim_conv2_output[(27*num_out)+r,c] + (conv2_padding[(31*k)+r+i,c+j]*Conv2_kernel[num_out,k,i,j])


#--bias+relu
for i in range(27*192):
    for j in range(27):
        sim_conv2_output[i,j] = sim_conv2_output[i,j] + Bias_conv2[i//27]
        if(sim_conv2_output[i,j] < 0):
            sim_conv2_output[i,j] =  0
          
Maxpool2_output = np.zeros((13*192,13))      
for k in range(192):
    for i in range(13):
        for j in range(13):
            temp = sim_conv2_output[(k*27)+(i*2),(j*2)]
            for r in range(3):
                for c in range(3):
                    if(sim_conv2_output[(k*27)+(i*2)+r,(j*2)+c]>temp):
                        temp = sim_conv2_output[(k*27)+(i*2)+r,(j*2)+c]
            Maxpool2_output[(13*k)+i,j]= temp

#---- "Input_conv3"
print('conv3')
conv3_padding = np.zeros((15*192,15))

for i in range(13*192):
    for j in range(13):
        conv3_padding[(i//13)*15+(i%13)+1,j+1] = Maxpool2_output[i,j]
        

sim_conv3_output = np.zeros((13*384,13))

for num_out in range(384):
    for k in range(192):
        for r in range(13):
            for c in range(13):
                for i in range(3):
                    for j in range(3):
                        sim_conv3_output[(13*num_out)+r,c] = sim_conv3_output[(13*num_out)+r,c]+ (conv3_padding[(15*k)+r+i,c+j]*Conv3_kernel[num_out,k,i,j])

#----bias+relu
for i in range(13*384):
    for j in range(13):
        sim_conv3_output[i,j] = sim_conv3_output[i,j] + Bias_conv3[i//13]
        if(sim_conv3_output[i,j] < 0):
            sim_conv3_output[i,j] =  0
#---- "Input_conv4"
print('conv4')
conv4_padding = np.zeros((15*384,15))

for i in range(13*384):
    for j in range(13):
        conv4_padding[((i//13)*15)+(i%13)+1,j+1] = sim_conv3_output[i,j]

sim_conv4_output = np.zeros((13*256,13))

for num_out in range(256):
    for k in range(384):
        for r in range(13):
            for c in range(13):
                for i in range(3):
                    for j in range(3):
                        sim_conv4_output[(13*num_out)+r,c] = sim_conv4_output[(13*num_out)+r,c]+ (conv4_padding[(15*k)+r+i,c+j]*Conv4_kernel[num_out,k,i,j])
#----bias+relu
for i in range(13*256):
    for j in range(13):
        sim_conv4_output[i,j] = sim_conv4_output[i,j] + Bias_conv4[i//13]
        if(sim_conv4_output[i,j] < 0):
            sim_conv4_output[i,j] =  0

#--- "Input_conv5"
print('conv5')
conv5_padding = np.zeros((15*256,15))

for i in range(13*256):
    for j in range(13):
        conv5_padding[(i//13)*15+(i%13)+1,j+1] = sim_conv4_output[i,j]

sim_conv5_output = np.zeros((13*256,13))

for num_out in range(256):
    for k in range(256):
        for r in range(13):
            for c in range(13):
                for i in range(3):
                    for j in range(3):
                        sim_conv5_output[(13*num_out)+r,c] = sim_conv5_output[(13*num_out)+r,c]+ (conv5_padding[(15*k)+r+i,c+j]*Conv5_kernel[num_out,k,i,j])

##----bias+relu
for i in range(13*256):
    for j in range(13):
        sim_conv5_output[i,j] = sim_conv5_output[i,j] + Bias_conv5[i//13]
        if(sim_conv5_output[i,j] < 0):
            sim_conv5_output[i,j] =  0

 
Maxpool3_output = np.zeros((6*256,6))
for k in range(256):          
    for i in range(6):
        for j in range(6):
            temp = sim_conv5_output[(k*13)+(i*2),(j*2)]
            for r in range(3):
                for c in range(3):
                    if(sim_conv5_output[(k*13)+(i*2)+r,(j*2)+c]>temp):
                        temp = sim_conv5_output[(k*13)+(i*2)+r,(j*2)+c]
            Maxpool3_output[(k*6)+i,j]= temp#*0.5
#for i in range(6*256):
#    for j in range(6):
#        print(Maxpool3_output[i][j])
#-----fc
print('fc1')
sim_FC1_output = np.zeros(4096)

for i in range(4096):
    for j in range(9216):
        sim_FC1_output[i] = sim_FC1_output[i] + (Maxpool3_output[j//6,j%6]*FC1_weight[i,j])

#----bias+relu
        
for i in range(4096):
    sim_FC1_output[i] = (sim_FC1_output[i] + Bias_fc1[i])#*0.5
    if(sim_FC1_output[i] < 0):
        sim_FC1_output[i] =  0
for i in range(4096):
    print(sim_FC1_output[i])
#-----fc
print('fc2')
sim_FC2_output = np.zeros(4096)

for i in range(4096):
    for j in range(4096):
        sim_FC2_output[i] = sim_FC2_output[i] + (sim_FC1_output[j]*FC2_weight[i,j])
#----bias+relu
for i in range(4096):
    sim_FC2_output[i] = sim_FC2_output[i] + Bias_fc2[i]
    if(sim_FC2_output[i] < 0):
        sim_FC2_output[i] =  0
        
#-----fc
print('fc3')
sim_FC3_output  = np.zeros(1000)      

for i in range(1000):
    for j in range(4096):
        sim_FC3_output[i] = sim_FC3_output[i] + (sim_FC2_output[j]*FC3_weight[i,j])
#----bias
for i in range(1000):
    sim_FC3_output[i] = sim_FC3_output[i] + Bias_fc3[i]

#=================predict======================  
champion = np.zeros((5))
champion_value = np.zeros((5))
for j in range(5):
    champion[j] = 0;
    champion_value[j] =0;


for i in range(1000):
    if (sim_FC3_output[i] > champion_value[4]):
        champion_value[4] = sim_FC3_output[i]
        champion[4] = i
        j = 4
        while(j>0):
            if (champion_value[j] > champion_value[j-1]):
                temp_value = champion_value[j]
                champion_value[j] = champion_value[j-1]
                champion_value[j-1] = temp_value;
        
                temp_index = champion[j]
                champion[j] = champion[j-1]
                champion[j-1] = temp_index
            j = j-1

print('predict')                           
for i in range(5):
    print('['+str(i)+'] = '+ str(champion[i]))
    