import torch
import torchvision.transforms as transforms

device = 'cuda' if torch.cuda.is_available() else 'cpu'
dtype =  torch.float32

def prepare_transformations():
    train_transform = transforms.Compose([
        transforms.ToPILImage(),
        transforms.RandomHorizontalFlip(),
        transforms.RandomAffine(degrees=15),
        transforms.ToTensor(),
        transforms.Normalize([0.7195, 0.5627, 0.5254], [0.0607, 0.0522, 0.0508])
    ])
    
    validation_transform = transforms.Compose([
        transforms.ToPILImage(),
        transforms.ToTensor(),
        transforms.Normalize([0.7195, 0.5627, 0.5254], [0.0607, 0.0522, 0.0508])
    ])
    
    return train_transform, validation_transform
        

def save_checkpoint(filename, model, optimizer, epoch):
    model.eval()
    save_state = {
        'state_dict' : model.state_dict(),
        'epoch' : epoch + 1,
        'optimizer' : optimizer.state_dict(),
                }
    print()
    print('Saving current parameters')
    print('___________________________________________________________')

    torch.save(save_state, filename)
        
        
def check_precision_and_recall(loader, model):
    # If we say it's cancer: how good of a prediction is it <-- Precision
    # Of all that had cancer, how many did we say have cancer? <-- Recall
    true_positives = 0
    predicted_positives = 0
    actual_positives = 0
    actual_negs = 0
    true_negatives = 0
    
    model.eval()  # set model to evaluation mode
    with torch.no_grad():
        for x, y in loader:
            x = x.to(device=device, dtype=dtype)  # move to device, e.g. GPU
            y = y.to(device=device, dtype=torch.long)
            scores = model(x)
            _, preds = scores.max(1)
            true_positives += sum([1 if (x1 == 1) and (y1 == 1) else 0 for x1, y1 in zip(preds, y)])
            true_negatives += sum([1 if (x1 == 0) and (y1 == 0) else 0 for x1, y1 in zip(preds, y)])
            predicted_positives += sum(preds==1)
            actual_positives += sum(y == 1)
            actual_negs += sum(y == 0)
            
            
        precision = (float(true_positives) / float(predicted_positives))
        recall = (float(true_positives) / float(actual_positives))
        specificity = (float(true_negatives) / float(actual_negs))
        F_score = (2 / (1/precision + 1/recall))
        
        print('PRECISION: Got %d / %d correct (%.2f)' % (true_positives, predicted_positives, precision*100))
        print('RECALL: Got %d / %d correct (%.2f)' % (true_positives, actual_positives, recall*100))
        print('SPECIFICITY: Got %d / %d correct (%.2f)' % (true_negatives, actual_negs, specificity*100))
        print('F_score: ' + str(F_score)) # Harmonic Mean
        
                
    model.train() # Set back to model.train
    return F_score

def load_model(model, optimizer, checkpoint_file):
    checkpoint = torch.load(checkpoint_file, map_location='cuda:0')
    model.load_state_dict(checkpoint['state_dict'])
    optimizer.load_state_dict(checkpoint['optimizer'])
    
    print("=> loaded checkpoint")