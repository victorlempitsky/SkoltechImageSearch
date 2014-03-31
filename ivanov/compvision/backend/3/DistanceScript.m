%% Get list of files
clc
clear all;
close all;

QuantizationFolder = '/mnt/Data/ProductQuantization/';
Folder = '/mnt/Data/SIFTs/';
ImgFolders = dir(Folder);
ImgFolders = ImgFolders(3:end);
% Imgs = [];
% for i = 1: size(ImgFolders,1)
%  mkdir(QuantizationFolder,ImgFolders(i).name); 
% end

% for i = 1:size(ImgFolders,1)
%     iFolder = [Folder ImgFolders(i).name '/'];
%     qFolder = [QuantizationFolder ImgFolders(i).name '/'];
%     iImgs = dir(iFolder);
%     iImgs = iImgs(3:end);
%     if i ~= 101
%         for j = 1:size(iImgs,1)
%             iImgs(j).name = [iFolder iImgs(j).name];
%             sp = strsplit(iImgs(j).name,'/');
%             iImgs(j).qname =[sprintf('%s%s',qFolder,char(sp(end)))];
%         end
%         Imgs = [Imgs; iImgs];
%     end
% end
% 
% disp('Imgs done.');


load('ImgStructs.mat');

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
 