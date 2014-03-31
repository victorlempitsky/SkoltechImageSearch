% clear all;
% close all;
QuantizationFolder = '/mnt/Data/ProductQuantization/ProductQuantizers/';

%  load('/mnt/Data/ProductQuantization/Data/IndxCombine.mat');  
% load('/mnt/Data/ProductQuantization/Data/PQStruct1.mat');
% load('/mnt/Data/ProductQuantization/Data/Indx_PQ.mat')
%  load('/mnt/Data/ProductQuantization/Data/pq.mat');

% load('/mnt/Data/ProductQuantization/Data/PQStruct2.mat');
% load('/mnt/Data/ProductQuantization/Data/PQStruct3.mat');
% load('/mnt/Data/ProductQuantization/Data/PQStruct4.mat');
% load('/mnt/Data/ProductQuantization/Data/PQStruct5.mat');
%  
% load('/mnt/Data/ProductQuantization/Data/PQStruct6.mat');
% load('/mnt/Data/ProductQuantization/Data/PQStruct7.mat');
% load('/mnt/Data/ProductQuantization/Data/PQStruct8.mat');
% load('/mnt/Data/ProductQuantization/Data/PQStruct9.mat');
% load('/mnt/Data/ProductQuantization/Data/PQStruct10.mat');
Idx = randi(2000,[1,1000]);
PQCodes = [PQCodes1];
vquery = randi(256,[128,1]);
tic;
[PQC,ImgIndx] = GetPQCodes(IdxStructs,PQCodes,Idx); 
toc;
cbase = PQC;
k = 100;
tic;
[id,dist] = pq_search (pq, cbase, vquery, k);
toc;
ImgIndices = ImgIndx(id);

