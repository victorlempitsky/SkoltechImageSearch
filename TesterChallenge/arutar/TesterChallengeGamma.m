clear all;
close all;

tic
% folder with images
Folder = '/Users/mikhail/Projects/images/';


Imgs = dir([Folder '*.jpg']);
corner_size = 100;
NumImgs = size(Imgs,1);
idx = randi(NumImgs);
disp(['Search index = ', num2str(idx)]);

% read image and apply gamma correction
img = double(imread([Folder Imgs(idx).name]));
img = img(1:corner_size, 1:corner_size, :) ./ 255;
img_e = gammacorrection(img,0.9);

% find image and display found index
idx_ = FindImageGamma(Folder, img_e);
disp(['Found index = ', num2str(idx_)]);

toc

