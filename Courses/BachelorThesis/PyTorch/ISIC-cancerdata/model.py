import torch
import torch.nn as nn
import torch.nn.functional as F

class FullyConnected(nn.Module):
    def __init__(self, drop_rate):
        super().__init__()
        self.drop_rate = drop_rate
        
        self.fc1 = nn.Linear(2048, 1024)
        self.drop1 = nn.Dropout2d(self.drop_rate)
        self.fc2 = nn.Linear(1024 , 512)
        self.drop2 = nn.Dropout2d(self.drop_rate)
        self.fc3 = nn.Linear(512, 2)
    
    def forward(self, x):
        z1 = self.fc1(x)
        a1 = F.relu(z1)
        a1 = self.drop1(a1)
        
        z2 = self.fc2(a1)
        a2 = F.relu(z2)
        a2 = self.drop2(a2)
        
        z3 = self.fc3(a2)
        return z3


    
