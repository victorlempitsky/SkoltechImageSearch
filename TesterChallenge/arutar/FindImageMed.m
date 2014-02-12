function [ imgIdx ] = FindImageMed( Folder, img )
%FINDIMAGE Summary of this function goes here
%   Detailed explanation goes here

Imgs = dir([Folder]);
ImgsSize = size(Imgs,1);
sizeX = size(img,1);
sizeY = size(img,2);
imgIdx = 0;

pointsx = randi(sizeX, 10, 1);
pointsy = randi(sizeY, 10, 1);

med1 = median(median(img(:,:,1)));
med2 = median(median(img(:,:,2)));
med3 = median(median(img(:,:,3)));
b1 = img(pointsx,pointsy,1) >= med1;
b2 = img(pointsx,pointsy,2) >= med2;
b3 = img(pointsx,pointsy,3) >= med3;
d1 = img(pointsx,pointsy,1) < med1;
d2 = img(pointsx,pointsy,2) < med2;
d3 = img(pointsx,pointsy,3) < med3;

distances = zeros(ImgsSize,1);
distances(1) = 10000;
distances(2) = 10000;

for i = 3:ImgsSize
    try
        img_ = double(imread([Folder '/' Imgs(i).name]));
        img_ = img_(1:sizeX, 1:sizeY, :) ./ 255;
        med1_ = median(median(img_(:,:,1)));
        med2_ = median(median(img_(:,:,2)));
        med3_ = median(median(img_(:,:,3)));
        
        a1 = img_(pointsx,pointsy,1) >= med1_;
        a2 = img_(pointsx,pointsy,2) >= med2_;
        a3 = img_(pointsx,pointsy,3) >= med3_;
        c1 = img_(pointsx,pointsy,1) < med1_;
        c2 = img_(pointsx,pointsy,2) < med2_;
        c3 = img_(pointsx,pointsy,3) < med3_;
        
        distances(i) = distances(i) + sum(sum(abs(a1~=b1)));
        distances(i) = distances(i) + sum(sum(abs(a2~=b2)));
        distances(i) = distances(i) + sum(sum(abs(a3~=b3)));
        distances(i) = distances(i) + sum(sum(abs(c1~=d1)));
        distances(i) = distances(i) + sum(sum(abs(c2~=d2)));
        distances(i) = distances(i) + sum(sum(abs(c3~=d3)));

        
    catch exc
        distances(i) = 10000;
    end
end

[~, imgIdx] = min(distances);

end

