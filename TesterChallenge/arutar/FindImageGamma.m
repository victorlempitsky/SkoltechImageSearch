function [ imgIdx ] = FindImageGamma( Folder, img )
%FINDIMAGE Summary of this function goes here
%   Detailed explanation goes here

Imgs = dir([Folder '/' '*.jpg']);
ImgsSize = size(Imgs,1);
sizeX = size(img,1);
sizeY = size(img,2);
imgIdx = 0;

for i = 1:ImgsSize
    img_ = double(imread([Folder '/' Imgs(i).name]));
    img_ = img_(1:sizeX, 1:sizeY, :) ./ 255;
    gamma = log(img) ./ log(img_);
    gamma_est = max(gamma(:)) - min(gamma(:));
    if ( gamma_est < 1e-09 && gamma_est ~= 0 )
        imgIdx = i;
        break;
    end
end

end

