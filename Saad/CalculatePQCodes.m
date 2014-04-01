%% This function calculates the PQ Codes of each Image and store it.
clc
clear all;
close all;

QuantizationFolder = '/mnt/Data/ProductQuantization/';
Folder = '/mnt/Data/SIFTs/';
ImgFolders = dir(Folder);
ImgFolders = ImgFolders(3:end);

load('/mnt/Data/productQuantization/Data/ImgStructs.mat');

%% Quantizer Calculation
totalCentroids = 256;
load('Centroids_m8.mat');
centroids = C_m8;
m=8;
sliceDim = 128/m;

tic;
parfor k = 1:size(Imgs,1)
      SIFTS= load(Imgs(k).name, '-mat', 'd');
      idx = uint8([]);
    for i = 1: size(SIFTS.d,2)
         % distances = bsxfun(@minus,C,X(:,i)).^2;
           distances = abs(repmat(double(SIFTS.d(:,i)),1,totalCentroids) - centroids);
         for j = 1:m
            [~,I] = min(sum(distances(((j-1)*sliceDim)+1:j*sliceDim,:),1));
            idx(j,i) = I-1;
         end
    end
         fname = sprintf('%s.mat',Imgs(k).qname);
         parsave(fname,idx);
         if mod(k,1000) == 0
            disp(strcat('Images done:',num2str(k)));     
         end
end
toc;
 