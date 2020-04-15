function data = ISIC_read_single_image(pathImage, pathDescription)

% Read image
image = imread(pathImage); %..\Data\Images\" + 

% Unroll image
unrolledImage = image(:);

% Get image information
imageinfo = readcell(pathDescription);
%..\Data\Descriptions\" + 

% Find row that contains information whether benign or malignant
index1 = find(strcmp(imageinfo, "benign_malignant:"), 1);
index2 = find(strcmp(imageinfo, "benign_malignant"), 1);

if length(index1) == 0 & length(index2) ~= 0
    index = index2;
elseif length(index1) ~= 0 & length(index2) == 0
    index = index1;
else
    index = [];     
end

if index
    % Extract whether benign or malignant, remove comma
    classification = string({imageinfo(index,2)});
    classification = strrep(classification,",","");

    %target = 0 if benign, 1 if malignant
    if classification == "malignant"
        target=1;
    else
        target=0;
    end

    data=[target; unrolledImage];
else
%     disp("Benign/Malignant information was not found for this image");
    data = [];
end