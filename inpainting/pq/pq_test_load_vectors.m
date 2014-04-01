


%        load('/mnt/gists/TrainingVectors.mat');
%        trainV = zeros(512,0);
%        for j = 1:57
%            for i =1: 1251
%               single = testTrain(j,:,i);
%                trainV = horzcat(trainV, single');
%            end
%        end
%        save('/mnt/gists/combineTrainingVector.mat', 'trainV');
       
%        load('/mnt/gists/DataVectors.mat');
%        dataV = zeros(512,0);
%          for j = 1:57
%            for i =1: 8750
%               single = data(j,:,i);
%                dataV = horzcat(dataV, single');
%            end
%          end
%        save('/mnt/gists/combineDataVector.mat', 'dataV');
       
%      t = zeros(512,0);
% 
%        for i=1:8750
%            single = matrix(1,:,i);
%            t = horzcat(t, single');
%        end
%        
%     basedir = './gist/' ;                    % modify this directory to fit your configuration
%     load('Holidaysfeaturess.mat');

load('/mnt/gists/uf/PQ.mat');   % load product quantized vectors
load('/mnt/gists/uf/fileOrder.mat'); % load file orders for indexing
load('/mnt/gists/assignments/dataVectors/features13.mat');   % selecting a query vetor
b = dataVec(:,650);
    
fquery =b;%dataVec(:,6000); 
vquery = fquery; 
    
