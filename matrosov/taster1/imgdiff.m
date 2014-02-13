function [ diff ] = imgdiff( img1, img2 )

img1 = double(img1);
img2 = double(img2);

if size(img1,3)==1 && size(img2,3)==3
    img2 = rgb2gray(img2/255)*255;
end

if size(img1,3)==3 && size(img2,3)==1
    img1 = rgb2gray(img1/255)*255;
end

if size(img1,3) ~= size(img2,3)
    diff = Inf;
    return;
end

diff = mean(mean(mean( (img1-img2).^2 )));

end

