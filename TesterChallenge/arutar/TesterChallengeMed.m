clear all;
close all;

tic
% folder with images
Folder = '/mnt/Images/4/';

Imgs = dir([Folder]);
NumImgs = size(Imgs,1);
% idx = randi(NumImgs);
% disp(['Search index = ', num2str(idx)]);

% read image and apply gamma correction
img = double(imread(['/mnt/Data/taster/fragment2.png']));
img = img ./ 255;

% find image and display found index
idx_ = FindImageMed(Folder, img);
disp(['Found index = ', num2str(idx_)]);

img_ = double(imread([Folder '/' Imgs(idx_).name]));
imshow(img_./255);

toc

