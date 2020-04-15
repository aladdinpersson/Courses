'''
This code is for training pretrained ResNext-101 network 
modified to train on ISIC-dataset. Included help functions 
check accuracy, load model, save model, etc. Depending on
what regularization technique you want to use, set dropout 
rate and weight_decay for l2 regularization.

'''

import torch
import torch.optim as optim
import torch.nn as nn
import sys
import torch.nn.functional as F
from torch.utils.data import DataLoader
from ISIC_dataset import ISIC_dataset
from utils.import_utils import *
from model import FullyConnected
from simple_fullynet import fullyNet

# Train CIFAR10 with a CNN or Fully Connected network
train_CNN = True
train_FC = False

# must train on either FC or CNN and cant train both at same time
assert (train_CNN or train_FC) == 1 and (train_CNN and train_FC) == 0 

class ISIC_CNN(object):
    def __init__(self):
        self.root_dir = 'Data/'
        self.train_csv_file = 'ISIC_train.csv'
        self.test_csv_file = 'ISIC_test.csv'
        self.validation_csv_file = 'ISIC_validation.csv'
        self.checkpoint_file = 'checkpoint/ISIC_CNN.pth.tar'
        
        self.device = 'cuda' if torch.cuda.is_available() else 'cpu'
        self.learning_rate = 1e-3
        self.weight_decay = 0.0
        self.dropout = 0.0
        self.num_epochs = 100
        self.batch_size = 2
        self.num_workers = 0
        
        self.dtype =  torch.float32
        self.shuffle = True
        self.pin_memory = True
        self.save_model = False
        
        self.transform_train, self.transform_val = prepare_transformations()

        self.train_loader = DataLoader(
            ISIC_dataset(self.root_dir, self.train_csv_file, self.transform_train),
            batch_size = self.batch_size,
            shuffle = self.shuffle,
            num_workers = self.num_workers,
            pin_memory = self.pin_memory)
        
        self.test_loader = DataLoader(
            ISIC_dataset(self.root_dir, self.test_csv_file, self.transform_val),
            batch_size = self.batch_size,
            shuffle = self.shuffle,
            num_workers = self.num_workers,
            pin_memory = self.pin_memory)
        
        self.validation_loader = DataLoader(
            ISIC_dataset(self.root_dir, self.validation_csv_file, self.transform_val),
            batch_size = self.batch_size,
            shuffle = self.shuffle,
            num_workers = self.num_workers,
            pin_memory = self.pin_memory)

    def setup_model(self, drop_rate):
        if train_CNN:
            # Loading pretrained ResNext101 model
            model = torch.hub.load('facebookresearch/WSL-Images', 'resnext101_32x16d_wsl')
            
            # Setting last fully connected layers to our defined FullyConnected
            model.fc = FullyConnected(drop_rate=drop_rate)
            
        elif train_FC:
            # Initialize model
            model = fullyNet(input_size=224*224*3, drop_rate=drop_rate, num_classes=2)

        return model
    
    def check_accuracy(self, loader, model):
        num_correct = 0
        num_samples = 0
        model.eval()  # set model to evaluation mode
        
        with torch.no_grad():
            for x, y in loader:
                x = x.to(device=self.device, dtype=self.dtype)  # move to device, e.g. GPU
                y = y.to(device=self.device, dtype=torch.long)
                
                if train_FC:
                    x = x.reshape(x.shape[0], -1)
                    
                scores = model(x)
                _, preds = scores.max(1)
                num_correct += (preds == y).sum()
                num_samples += preds.size(0)
            acc = (float(num_correct) / num_samples) * 100.0
            
        model.train()
        print('Got %d / %d correct (%.2f)' % (num_correct, num_samples, acc))
        return acc
        
    def main(self):
        model = self.setup_model(self.dropout).to(self.device)
        weight = torch.FloatTensor([1, 10]).cuda()
        criterion = nn.CrossEntropyLoss(weight=weight)
        optimizer = optim.SGD(model.parameters(), lr=self.learning_rate, weight_decay=self.weight_decay)
        
        # Make sure loading from correct checkpoint
        #load_model(model, optimizer, self.checkpoint_file)
        
        # If loaded model then we need to update learning rate and weight decay parameters
        for param_group in optimizer.param_groups:
            param_group['lr'] = self.learning_rate
            param_group['weight_decay'] = self.weight_decay

        for epoch in range(self.num_epochs):
            num_correct, total_checked = 0, 0
            losses = []

            # Check scores on validation each epoch (after at least training 1 epoch)
            if epoch >= 1: 
                print("Checking scores on validation...")
                f_score = check_precision_and_recall(self.validation_loader, model)

            for batch_idx, (data, targets) in enumerate(self.train_loader):
                data = data.to(device=self.device, dtype=self.dtype)
                targets = targets.to(device=self.device, dtype=torch.long)
                
                if train_FC:
                    data = data.reshape(data.shape[0], -1)
                    
                #forward prop
                scores = model(data)
                loss = criterion(scores, targets)
                losses.append(loss.item())
                
                #backward pass
                optimizer.zero_grad() # Zero gradients from prev. batch
                loss.backward() # Backpropogation
                optimizer.step() # GD step
                
                # For running training accuracy accuracy, NOTE:
                # Running training accuracy is not accurate (and especially not)
                # after a single epoch, but saves on compute
                _, preds = scores.max(1)
                num_correct += (preds == targets).sum()
                total_checked += preds.size(0)
            
            
            if self.save_model:
                save_checkpoint(self.checkpoint_file, model, optimizer, epoch)
                
            # Print metrics after 1 training epoch
            print(f'Mean loss this epoch: {sum(losses)/len(losses):.4f}')
            print('VALIDATION:')
            self.check_accuracy(validation_loader, model)
            print(f'Accuracy Training: {float(num_correct)/float(total_checked):.4f}')
            print('\n')


if __name__ == '__main__':
    net = ISIC_CNN()
    net.main()