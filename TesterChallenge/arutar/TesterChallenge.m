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

% read image
img = double(imread([Folder Imgs(idx).name]));
img = img(1:corner_size, 1:corner_size, :) ./ 255;

% find image and display found index
idx_ = FindImage(Folder, img);
disp(['Found index = ', num2str(idx_)]);

toc

