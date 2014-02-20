clear all;
close all;

folder_with_images = '/home/m273/SkVisual/Data/';

Images = dir([folder_with_images '*.jpg']);
Number_of_Images = size(Images,1);

img = double(imread([folder_with_images Images(42).name]));
model = img(1:100, 1:100, :);

found = 0;

for i = 1:Number_of_Images
    img = imreadbw([folder_with_images Images(i).name]);
    
    piece_to_compare = img(1:length(model(1,:,:)), 1:length(model(:,1,:)), :);
    
    if (piece_to_compare == model)
        found = 1;
        disp(['this is from ' Images(i).name])
    end

end

if found == 0
    disp('I cannot find an image')
end
