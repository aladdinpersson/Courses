% This function reads all images in folder Data/resized_images and
% their corresponding labels. Stores every image and label into a matrix
% and if save_as_csv is set to True then will write this matrix to csv file
% cancer_data.csv

function data = import_ISIC(save_as_csv)
    myDir_images = "Data/new_resized/";
    myDir_descriptions = "Data/Descriptions/";

    myFiles = dir(fullfile(myDir_images, "*.jpeg"));
    files_vector = {myFiles.name};
    data = [];
    count = 1;
    not_loaded = 0;
    
    for file = files_vector
        disp('Currently loaded: ' + string(count) + ' images');
        
        pathImage = strcat(myDir_images, string(file));
        desription_file = strrep(string(file), ".jpeg", "");
        pathDescription = strcat(myDir_descriptions, desription_file);
        data_one_image = ISIC_read_single_image(pathImage, pathDescription);
        
        if length(data_one_image) == 0
            disp('Tried to load ' + string(file));
            not_loaded = not_loaded + 1
            disp('Unsucessfully loaded: ' + string(not_loaded));
        else
            data(:,count) = data_one_image;
            count = count+1;
        end

    end
 
    if save_as_csv % if True then write else skip
        disp("Writing all to csv file ...")
        writematrix(data,'cancer_data.csv') 
        disp("Successfully wrote to csv file")
    end
end


