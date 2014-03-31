%% Clear
clc
clear all;
close all;

%% Load Data
load('Imgs.mat');
load('vocabulary_255.mat');
load('data.mat'); % load hash_funs, kd-trees, subs

%% Get Sketches
hm = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

n = 2; % number of elements per sketch
k = 512; % number of sketches
N = 512; % number of min-hashes
arr_size = 10000; % number of maps of sketches of images to save

arr = cell(arr_size,1);

tic

% get maps of sketches for images
for i = 1:500000
    if mod(i,arr_size) == 0
        arr{arr_size} = foo(i, Imgs, kdtree_u, C_255_u, kdtree_d, C_255_d, hash_funs, subs);
        i / numel(Imgs)
        save(['sketches_100k_' num2str(i / arr_size) '.mat'], 'arr');
        arr = cell(arr_size,1);
    else
        arr{i - floor(i / arr_size) * arr_size} = foo(i, Imgs, kdtree_u, C_255_u, kdtree_d, C_255_d, hash_funs, subs);
    end
end

toc

save(['sketches_100k_' num2str(100) '.mat'], 'arr');

toc






