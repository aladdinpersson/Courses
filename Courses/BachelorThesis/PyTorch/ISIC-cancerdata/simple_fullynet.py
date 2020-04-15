import torch
import torch.nn as nn
import torch.nn.functional as F

class fullyNet(nn.Module):
    def __init__(self, input_size, drop_rate, init_weights = True, num_classes=10):
        super(fullyNet, self).__init__()
        p = drop_rate
        self.fc1 = nn.Linear(input_size, 500)
        self.drop1 = nn.Dropout2d(p)
        self.fc2 = nn.Linear(500, 100)
        self.drop2 = nn.Dropout2d(p)
        self.fc3 = nn.Linear(100, 50)
        self.drop3 = nn.Dropout2d(p)
        self.fc4 = nn.Linear(50, 25)
        self.drop4 = nn.Dropout2d(p)
        self.fc5 = nn.Linear(25, num_classes)
        
        
        if init_weights:
            self._initialize_weights()

    def forward(self, x):
        z1 = self.fc1(x)
        a1 = F.relu(z1)
        a1 = self.drop1(a1)
        
        z2 = self.fc2(a1)
        a2 = F.relu(z2)
        a2 = self.drop2(a2)
        
        z3 = self.fc3(a2)
        a3 = F.relu(z3)
        a3 = self.drop3(a3)
        
        z4 = self.fc4(a3)
        a4 = F.relu(z4)
        a4 = self.drop4(a4)
        
        z5 = self.fc5(a4)
        return z5


    def _initialize_weights(self):
        for m in self.modules():
            if isinstance(m, nn.Linear):
                nn.init.kaiming_normal_(m.weight, mode='fan_in', nonlinearity='relu')
                nn.init.constant_(m.bias, 0)
                
def test_fullyNet():
    input_size = 100
    net = fullyNet(input_size, drop_rate=0.0)
    x = torch.randn(64,input_size)
    y = net(x)
    print(y.size())

if __name__ == '__main__':
    test_fullyNet()