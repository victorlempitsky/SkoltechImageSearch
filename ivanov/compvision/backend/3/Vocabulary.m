%% Get list of files
clc
clear all;
close all;

Folder = '/mnt/Data/SIFTs/';
ImgFolders = dir(Folder);
ImgFolders = ImgFolders(3:end);
Imgs = [];

for i = 1:size(ImgFolders,1)
    iFolder = [Folder ImgFolders(i).name '/'];
    iImgs = dir(iFolder);
    iImgs = iImgs(3:end);
    for j = 1:size(iImgs,1)
        iImgs(j).name = [iFolder iImgs(j).name];
    end
    Imgs = [Imgs; iImgs];
end

disp('Imgs done.');

%% Get 1M SIFTs
idxs = randsample(size(Imgs, 1), 100000);

sifts = zeros(128, 1000000);

for i = 1:100000
    try
        sift = load(Imgs(idxs(i)).name, '-mat', 'd');
        sifts(:,(i-1)*10+1:i*10) = vl_colsubset(sift.d, 10);
    catch exc
    end
end

save('sifts.mat', 'sifts');

disp('Sifts done.');

%% Constracting 2^10 vocabulary
[C_10, A_10] = vl_kmeans(sifts, 2^10);
save('vocabulary_1k.mat', 'C_10', 'A_10');
disp('2^10 done.');
%% Constracting 2^11 vocabulary
[C_11, A_11] = vl_kmeans(sifts, 2^11);
save('vocabulary_2k.mat', 'C_11', 'A_11');
disp('2^11 done.');
%% Constracting 2^12 vocabulary
[C_12, A_12] = vl_kmeans(sifts, 2^12);
save('vocabulary_4k.mat', 'C_12', 'A_12');
disp('2^12 done.');

% %% Constracting 2^13 vocabulary
% [C_13, A_13] = vl_kmeans(sifts, 2^13);
% save('vocabulary_8k.mat', 'C_13', 'A_13');
% 
% disp('2^13 done.');
% %% Constracting 2^14 vocabulary
% [C_14, A_14] = vl_kmeans(sifts, 2^14);
% save('vocabulary_16k.mat', 'C_14', 'A_14');
% 
% disp('2^14 done.');