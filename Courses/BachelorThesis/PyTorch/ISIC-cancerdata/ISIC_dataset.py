from torch.utils.data import Dataset
import pandas as pd
import os
import numpy as np
import torch
from skimage import io

class ISIC_dataset(Dataset):
    def __init__(self, root_dir, csv_file, transform=None):
        self.root_dir = root_dir
        self.annotations = pd.read_csv(self.root_dir + csv_file)
        self.transform = transform

    def __len__(self):
        return len(self.annotations)

    def __getitem__(self, index):
        img_name = os.path.join(self.root_dir + '/Images_resized', self.annotations.iloc[index, 0])
        image = io.imread(img_name)
        y_label = int(self.annotations.iloc[index, 1])

        if self.transform:
            image = self.transform(image)

        return image, y_label