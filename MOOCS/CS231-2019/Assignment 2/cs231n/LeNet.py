
# coding: utf-8

# In[4]:


import torch
import torch.nn.functional as F
import torch.nn as nn


# In[6]:


class LeNet(nn.Module):
    def __init__(self, in_channels, num_classes = 10, init_weights = True):
        super().__init__()
        self.conv1 = nn.Conv2d(in_channels, out_channels = 6, kernel_size = 5)
        self.conv2 = nn.Conv2d(in_channels = 6, out_channels = 16, kernel_size = 5)
        self.fc1 = nn.Linear(16*5*5, 120)
        self.fc2 = nn.Linear(120, 84)
        self.fc3 = nn.Linear(84, 10)

        if init_weights:
            self.initialize_weights()


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


    def forward(self, x):
        z1 = self.conv1(x)
        a1 = F.relu(z1)
        a1 = F.max_pool2d(a1, 2)

        z2 = self.conv2(a1)
        a2 = F.relu(z2)
        a2 = F.max_pool2d(a2, 2)

        a2 = a2.view(a2.size(0), -1)
        z3 = self.fc1(a2)
        a3 = F.relu(z3)

        z4 = self.fc2(a3)
        a4 = F.relu(z4)
        z5 = self.fc3(a4)
        scores = z5
        return scores

def test():
    x = torch.randn((64, 1, 32, 32))  # minibatch size 64, image size [3, 32, 32]

    model = LeNet(1, 10)
    y = model(x)
    print(y.size())  # you should see [64, 10]
test()
