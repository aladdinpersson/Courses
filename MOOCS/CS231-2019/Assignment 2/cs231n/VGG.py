
# coding: utf-8

# In[11]:


import torch
import torch.nn.functional as F
import torch.nn as nn


# In[12]:


VGG_types = {'VGG_own': [64, 64,'M', 128, 128, 'M',256, 256, 'M', 512, 512, 'M'],
'VGG16':[64, 64, 'M', 128, 128, 'M', 256, 256, 256, 'M', 512, 512, 512, 'M', 512, 512, 512, 'M']}


# In[14]:


class VGG(nn.Module):
    def __init__(self, in_channels, vgg_type = 'VGG16', num_classes = 10, init_weights = True):
        super().__init__()
        self.in_channels = in_channels
        self.layout = self.create_architecture(VGG_types[vgg_type])
        self.fc = nn.Linear(512, num_classes)
        # self.fcs = nn.Sequential(
        #     nn.Linear(512 * 1 * 1, 4096),
        #     nn.ReLU(),
        #     nn.Dropout(),
        #     nn.Linear(4096, 4096),
        #     nn.ReLU(),
        #     nn.Dropout(),
        #     nn.Linear(4096, num_classes)
        # )
        if init_weights:
            self.initialize_weights

    def initialize_weights(self):
        for m in self.modules():
            if isinstance(m, nn.Conv2d):
                nn.init.kaiming_normal_(m.weight, mode='fan_out', nonlinearity='relu')
                if m.bias is not None:
                    nn.init.constant_(m.bias, 0)

            elif isinstance(m, nn.BatchNorm2d):
                nn.init.constant_(m.weight, 1)
                nn.init.constant(m.bias, 0)

            elif isinstance(m, nn.Linear):
                nn.init.normal_(m.weight, 0, 0.01)
                nn.init.contant_(m.bias, 0)


#     def calculate_avg(pixel_size):
#         out = pixel_size/(2**5)
#         return out

    def create_architecture(self, architecture):
        layers = []

        for x in architecture:
            if type(x) == int:
                out_channels = x
                layers += [nn.Conv2d(self.in_channels, out_channels, kernel_size = 3, padding =1),
                          nn.BatchNorm2d(out_channels),
                          nn.ReLU(inplace = False)]

                self.in_channels = out_channels

            else:
                layers += [nn.MaxPool2d(kernel_size =2, stride = 2)]

        return nn.Sequential(*layers)


    def forward(self, X):
        out = self.layout(X)
        out = out.view(out.size(0), -1)
        out = self.fc(out)
        return out

def test():
    x = torch.randn((64, 1, 32, 32))  # minibatch size 64, image size [3, 32, 32]

    model = VGG(1,'VGG16', 10)
    y = model(x)
    print(y.size())  # you should see [64, 10]
test()

def hello():
    print('hello')
