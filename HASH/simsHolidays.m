%% Get list of files
clc
clear all;
close all;

%% Load Data
load('/mnt/Data/SIFTs/Holidays.mat', '-mat');
load('vocabulary_255.mat');

%% Get Sketches
hm = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

n = 2; % number of elements per sketch
k = 512; % number of sketches
N = 512; % number of min-hashes
vocabulary_size = 255^2;

hash_funs = single(rand(vocabulary_size, N));
min_hashes = uint16(zeros(numel(sifts), N));

% kdtree = vl_kdtreebuild(C_30);
kdtree_u = vl_kdtreebuild(C_255_u);
kdtree_d = vl_kdtreebuild(C_255_d);

subs = zeros(k,n);
if N / k == n
    for i = 1:k
        subs(i,:) = (i - 1) * n + 1 : i * n;
    end
elseif N / k == 1
    for i = 1:k / 2
        subs(i,:) = (i - 1) * n + 1 : i * n;
        subs(k / 2 + i,:) = (i - 1) * n + 2 : i * n + 1;
    end
    subs(k, :) = [N 1];
end

% array = [];
tic
for i = 1:numel(sifts)
    % load sift
    sift = sifts{i};
    sift = double(sift);
    
    % kdtrees for half sifts for 2 vocabularies of 255 words (less than a second)
    idxs_u = vl_kdtreequery(kdtree_u, C_255_u, sift(1:64,:));
    idxs_d = vl_kdtreequery(kdtree_d, C_255_d, sift(65:128,:));
    idxs = (idxs_u - 1) .* 255 + idxs_d;
    idxs = unique(idxs);
    
    % get min hashes
    [~, idx] = min(hash_funs(idxs,:));
    min_hash = idxs(idx);
    
    % save min_hashes
    min_hashes(i,:) = uint16(min_hash);
    
    % save sketches
%     idx = num2str(min_hash(subs), '%05u');
    idx = min_hash(subs(:,1)) .* min_hash(subs(:,2));
    
    for j = 1:size(idx,2)
        if hm.isKey(idx(j))
            hm(idx(j)) = uint32([hm(idx(j)) i]);
        else
            hm(idx(j)) = uint32(i);
        end
    end
%     i / numel(sifts)
end
toc











