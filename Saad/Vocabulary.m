%% This function takes the random SIFTS from the whole Set and combine them together for Vocabulary
 
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
