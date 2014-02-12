clear all;
close all;

tic
% folder with images
% Folder = '/Users/mikhail/Projects/images/';
Folder = '/mnt/Images/6/';

Imgs = dir([Folder]);
corner_size = 100;
NumImgs = size(Imgs,1);
% idx = randi(NumImgs);
% idx = 3;

% disp(['Search index = ', num2str(idx)]);

% read image
img = double(imread(['/mnt/Data/taster/fragment1.png']));
img = img ./ 255;

% find image and display found index
idx_ = FindImage(Folder, img);
disp(['Found index = ', num2str(idx_)]);

img_ = double(imread([Folder '/' Imgs(idx_).name]));
imshow(img_./255);

toc

