%% Clear
clc
clear all;
close all;

%% Load Data
load('Imgs.mat');
load('vocabulary_255.mat');
load('data.mat'); % load hash_funs, kd-trees, subs

%% Get Min-Hashes
n = 2; % number of elements per sketch
k = 512; % number of sketches
N = 512; % number of min-hashes
vocabulary_size = 255^2;
arr_size = 10000;
min_hashes = zeros(500000, N);

tic

% get min_hashes for images
for i = 1:500000
    try
        min_hashes(i,:) = uint16(foo2(i, Imgs, kdtree_u, C_255_u, kdtree_d, C_255_d, hash_funs, subs));
    catch exc
    end
    if mod(i,arr_size) == 0
        i / 500000
        save(['min_hashes_' num2str(i/arr_size) '.mat'], 'min_hashes')
    end
    
end

toc






