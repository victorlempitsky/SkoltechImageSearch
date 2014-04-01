%% This function combines all the PQ Codes in one folder and create their Index
clc
clear all;
close all;

QuantizationFolder = '/mnt/Data/ProductQuantization/';
Folder = '/mnt/Data/SIFTs/';
ImgFolders = dir(QuantizationFolder);
ImgFolders = ImgFolders(3:end);


for i = 1:length(ImgFolders)
    qFolder = [QuantizationFolder ImgFolders(i).name '/'];
    iImgs = dir(qFolder);
    iImgs = iImgs(3:end);
    QuantizerSet = [];
    QuantizerIndex = {};
    idx = 0;
    tic;
    fname = sprintf('%sQSet_%d.mat',qFolder,i);
    if exist(fname) == 0
        for j = 1:size(iImgs,1)
              name = [qFolder iImgs(j).name];
              q = load(name);
              QuantizerSet = [QuantizerSet q.data];
              QuantizerIndex(j).startIndex = idx+1;
              idx = idx + size(q.data,2);
              QuantizerIndex(j).EndIndex = idx;
              sp = strsplit(iImgs(j).name,'/');
              QuantizerIndex(j).name =  sp(end);
        end
    fname = sprintf('%sQSet_%d.mat',qFolder,i);
    parsave(fname,QuantizerSet);
    fname = sprintf('%sQIndex_%d.mat',qFolder,i);
    parsave(fname,QuantizerIndex);
    fprintf('Folder Done:%d',i)
    toc;
    end
end
