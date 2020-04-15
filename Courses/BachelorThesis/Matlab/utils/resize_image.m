% This small script is to go thrpugh each image in Data/Images folder,
% and for each output a resized image into folder Data/rezied_images 
% with size. This script should just be run once, after setting the dataset
% in the correct folders.

clear all; close all; clc;

size = [64,64];
path = "../Data/Images/";
newpath = "../Data/new_resized/";
myFiles = dir(fullfile(path, "*.jpeg")); % Finds all jpegs in folder
files_in_folder = {myFiles.name}; % Make all jpegs file into a vector

% Found a way to utilize parallel computing toolbox to make resizing
% the 24k images go a little bit faster. Using parfor instead of for.
% Takes about ~20 minutes even using parallel computing toolbox.

parfor (idx = 1:length(myFiles))
    file = files_in_folder(idx);
    idx
    image = imread(path + string(file)); % Read the jpeg file into tensor
    resizedImage = imresize(image,size); % Resize image
    imwrite(resizedImage, newpath + string(file)) % Output resized image
end

% If you don't have parallel computing toolbox, this works as well.
% Just a bit slower.

% total_resized = 0;
% for file = files_in_folder 
%     image = imread(path + string(file)); % Read the jpeg file into tensor
%     resizedImage = imresize(image,size); % Resize image
%     imwrite(resizedImage, newpath + string(file)) % Output resized image
%     total_resized = total_resized + 1;
%     disp('Total resized: ' + string(total_resized))
% end