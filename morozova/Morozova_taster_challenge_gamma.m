clear all;
close all;

folder_with_images = '/home/m273/SkVisual/Data/';

Images = dir([folder_with_images '*.jpg']);
Number_of_Images = size(Images,1);

img = imreadbw([folder_with_images Images(9).name]);
model = img(1:100, 1:100);
model = single(gammacorrection(model, 0.5));
[~, model] = vl_phow(model);
number = numel(model);
saved = 0;
savedi = 0;

for i = 1:Number_of_Images
    disp(['i = ' num2str(i)]);
    img = single(imreadbw([folder_with_images Images(i).name]));
    img = img(1:100, 1:100);
    
    [~, dsift] = vl_phow(img);
    
    
    res = sum(sum(dsift == model));
    current = res/number;
    display(['Picture ', num2str(i), ' ', num2str(current)]);
    
    if current > saved
        saved = current;
        savedi = i;
    end
        
    %imshow(img)
    %pause(2)
end

display(['Best Picture ', num2str(savedi), ' ', num2str(saved)]);
