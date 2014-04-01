 %% The main Function that loads the Data and also performs a sample Query
 clear all;
 close all;
QuantizationFolder = '/mnt/Data/ProductQuantization/ProductQuantizers/';
% 
 load('/mnt/Data/ProductQuantization/Data/IndxCombine.mat');  
  load('/mnt/Data/ProductQuantization/Data/PQStruct1.mat');
 load('/mnt/Data/ProductQuantization/Data/Indx_PQ.mat')
  load('/mnt/Data/ProductQuantization/Data/pq.mat');
  
 load('/mnt/Data/ProductQuantization/Data/PQStruct2.mat');
  load('/mnt/Data/ProductQuantization/Data/PQStruct3.mat');
  load('/mnt/Data/ProductQuantization/Data/PQStruct4.mat');
 load('/mnt/Data/ProductQuantization/Data/PQStruct5.mat');

 load('/mnt/Data/ProductQuantization/Data/PQStruct6.mat');
 load('/mnt/Data/ProductQuantization/Data/PQStruct7.mat');
 load('/mnt/Data/ProductQuantization/Data/PQStruct8.mat');
 load('/mnt/Data/ProductQuantization/Data/PQStruct9.mat');
 load('/mnt/Data/ProductQuantization/Data/PQStruct10.mat');

 
Idx = randi(2000,[1,1000]);     %Randomly Taking Set For Query

PQCodes = [PQCodes1 PQCodes2 PQCodes3 PQCodes4 PQCodes5 PQCodes6 PQCodes7 PQCodes8 PQCodes9 PQCodes10];
Sift = load(['/mnt/Data/SIFTs/1/19841.701408'], '-mat', 'd'); %Sample Query
vquery = double(Sift(1).d(:,1));
tic;  
    [PQC,ImgIndx] = GetPQCodes(IdxStructs,PQCodes,Idx);   %get the PQ Codes and Image Indices of Random Set
toc;
%cbase = PQCodes;
k = 10;     %Number of Nearest Neighbours
tic;
[id,dist] = pq_search (pq, PQC, vquery, k);
toc;
Imgs = {};
 for i = 1:length(id)
    for j =1 : length(IdxStructs)
        if id(i) >= IdxStructs(j).startIndex && id(1) <= IdxStructs(j).EndIndex
           Imgs{i} = IdxStructs(j).name;
        end
    end
 end
 QuantizationFolder = '/mnt/Data/Images/';
 
for i = 1:10
    e = cellstr(Imgs(i));
    fname = sprintf('%s/%d/%s',QuantizationFolder,i,e);
  if exist(fname,'file')
    im = load(fname,'-mat','d');
    imshow(im);
  end
end
%ImgIndices = ImgIndx(id);

