% % usage: "query='imgs/1/123.456.jpg'; output='output.txt'; backend; result"
% 
%queries={
%    'http://legendyboxing.ru/uploads/posts/2011-08/1313657138_boxing.jpg'
%    'http://www.sunhome.ru/UsersGallery/122008/1572300.jpg'
%    'http://www.businessweek.com/business_at_work/bad_bosses/archives/boxing.jpg'
%    'http://img.sunhome.ru/UsersGallery/012008/1680504.jpg'
%    'http://1.bp.blogspot.com/-6GN_RUi2ugY/Tfkx8ItK2mI/AAAAAAAACuA/fI89r5L0c14/s1600/Boxing.jpg'
%    'http://www.guzer.com/pictures/boxing-punch.jpg'
%    'http://i53.fastpic.ru/big/2013/0223/46/39f6caccbbb5d36791a76f9276f3fc46.jpg'
%    'http://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Boxing080905_photoshop.jpg/220px-Boxing080905_photoshop.jpg'};
ExactFlag=1;

%% How many images to rerank
N_RESULTS = 300;

MULTIPLE_QUERIES = 1;

tic;
%% This is Misha's Ranking
if ~exist('filenames', 'var')
      %load ('/mnt/Data/VLADs/pqPcaVladDataAsClassAll')
    load ('/mnt/Data/VLADs/filenamesAll')
    load ('/mnt/Data/VLADs/clusters')
    load ('/mnt/Data/VLADs/clustersAdaptedCenters')
    load ('/mnt/Data/VLADs/pca')
    load ('/mnt/Data/VLADs/pqPcaEncodings')
    load ('/mnt/Data/VLADs/pcaEncodingsAll.mat')
    load ('/mnt/Data/VLADs/pqClusters')
    load ('/mnt/Data/VLADs/pqDistances')
    load ('/mnt/Data/VLADs/pqRotation')
    pqPcaVladData = PqPcaVladData(pqPcaEncodings, encodings, clusters,...
       adaptedCenters, coeff, pqClusters, pqRotation, pqDistances, N_RESULTS);
    clear pqPcaEncodings encodings clusters adaptedCenters
    clear coeff pqClusters pqRotationpqDistances
    toc;
end

queries = strsplit(query, '\n');

n_queries = numel(queries)-4;
%ranks = spalloc(n_queries, size(pqPcaEncodings,2), n_queries*N_RESULTS);

if MULTIPLE_QUERIES
    ranks = [];
    parfor i=1:n_queries
        try
            ranks(i,:) = backendNotParallel (queries{i}, pqPcaVladData);
        catch err
            ranks(i,:) = zeros(numel(filenames));
            fprintf('Couldn''t process img "%s"\n', queries{i});
        end
    end
    
    ixs = [];
    for i=1:size(ranks,1)
        [~,ix] = sort(ranks(i,:), 'descend');
        ixs(end+1,:) = ix(1:N_RESULTS);
    end
    if size(ranks,1)>1
        [ranks,ix] = sort(mean(ranks), 'descend');
    else
        [ranks,ix] = sort(ranks, 'descend');
    end
    ixs = [ix(1:N_RESULTS)';ixs(:)]; % combine
else
    try
        ranks = backendNotParallel (queries{1}, pqPcaVladData);
        [ranks,ixs] = sort(ranks, 'descend');
        ixs = ixs(1:N_RESULTS);
    catch err
        fprintf('Couldn''t process img "%s"\n', queries{i});
    end
end


ixs = ixs(1:N_RESULTS);

fprintf('Processed %d images.\n', n_queries);
toc;

% write result
% result = sprintf('/mnt/Images/%s\n', filenames{ixs});

%% This is Reranking based on PQ structures from Saad
if (ExactFlag==1)
    if ~exist('PQCodes1', 'var')
      %  display('aaaaaaaaaa');
        load('/mnt/Data/ProductQuantization/Data/IndxCombine.mat');  
        load('/mnt/Data/ProductQuantization/Data/PQStruct1.mat');
        load('/mnt/Data/ProductQuantization/Data/Indx_PQ.mat')
        load('/mnt/Data/ProductQuantization/Data/pq.mat');

        load('/mnt/Data/ProductQuantization/Data/PQStruct1.mat');
        load('/mnt/Data/ProductQuantization/Data/PQStruct2.mat');
        load('/mnt/Data/ProductQuantization/Data/PQStruct3.mat');
        load('/mnt/Data/ProductQuantization/Data/PQStruct4.mat');
        load('/mnt/Data/ProductQuantization/Data/PQStruct5.mat');

        load('/mnt/Data/ProductQuantization/Data/PQStruct6.mat');
        load('/mnt/Data/ProductQuantization/Data/PQStruct7.mat');
        load('/mnt/Data/ProductQuantization/Data/PQStruct8.mat');
        load('/mnt/Data/ProductQuantization/Data/PQStruct9.mat');
        load('/mnt/Data/ProductQuantization/Data/PQStruct10.mat');
%         [PQCodes1, PQCodes2, PQCodes3, PQCodes4, PQCodes5, PQCodes6,  PQCodes7, PQCodes8, PQCodes9, PQCodes10 ];
    end
    k = 10;
    SIFTsfrom=100;
    
    Idx = ixs; %indexes of images to rerank
    Images2Rerank=filenames{ixs};
    
    Images=cell(1,n_queries);
    QSIFTs=cell(1,n_queries);
    querySIFTsNum=cell(1,n_queries);
    
    %% SIFTs Calculation
    for i=(1:n_queries)
        try
            Images{1,i}=single(rgb2gray(imread(queries{i})));
            tic;
            [~,QSIFTs{1,i}] = vl_sift(Images{1,i}) ;
            toc;
            querySIFTsNum{1,i}=size(QSIFTs{1,i},2);
        catch err
            QSIFTs{1,i} = 0;
            querySIFTsNum{1,i}=0;
            fprintf('Couldn''t open img "%s"\n', queries{i});
        end
    end
    display('image SIFTs calculated...');
    Ncounted=cell(1,n_queries);
    RankingSIFTs=cell(1,n_queries);
    for i=(1:n_queries)
        if (querySIFTsNum{1,i}>0)
            Ncounted{1,i}=min(SIFTsfrom,querySIFTsNum{1,i});

            % N=querySIFTsNum;
    %         answ=8;
            %% Ranking SIFTs
            if ( Ncounted{1,i}==SIFTsfrom)
                q=randi(size(QSIFTs{1,i},2), Ncounted{1,i});
                q=q(:,1);
                q=sort(q);
                j=1;
                while (j<=size(q,1)-1)
                    curSIFT=q(j);
                    nextSIFT=q(j+1);
                    if (curSIFT==nextSIFT)
                            a=q((1:(j)),:);
                            b=q(((j+2):end),:);
                            q=[a; b];
                            continue;
                    end
                    j=j+1;
                end
                q=q';
                RankingSIFTs{1,i}=QSIFTs{1,i}(:,q(:));
                Ncounted{1,i}=size(q,2);
                 % display(Ncounted{1,i});
            end
        end
    end
    %% 
%     vquery = randi(256,[128,100]);
    %% Get PQ codes for reranking images
    tic;
    [PQC,ImgIndx] = GetPQCodes(IdxStructs,[PQCodes1 PQCodes2 PQCodes3 PQCodes4 PQCodes5 PQCodes6  PQCodes7 PQCodes8 PQCodes9 PQCodes10],Idx); 
    display('PQ codes extracted...');
    nb=zeros(N_RESULTS,1);
    
    for i=(1:N_RESULTS)
        id=Idx(i,1);
        nb(i,1)=find(ImgIndx==id, 1, 'last' )-find(ImgIndx==id, 1 )+1;
    end

    toc;
    cbase = PQC;
    %% Reranking
    tic;
    id=cell(0);
    dist=cell(0);
    ScoresTotal=zeros(N_RESULTS,2);
    ScoresTotal(:,1)=ixs;
    for i=(1:n_queries)
        if (querySIFTsNum{1,i}>0)
            kNN=zeros(Ncounted{1,i},k);
            DistM=zeros(Ncounted{1,i},k);
            for j=(1:Ncounted{1,i})
                vquery=RankingSIFTs{1,i}(:,j);
                [kNN(j,:),DistM(j,:)] = pq_search (pq, cbase, single(vquery), k);
                
               
%                 [~, I] = sort((-scores(:,3)));
%                 idx=I(1:answ);
%                 output=scores(I,:);
            end
            [ scores ] = ScoringFunc( N_RESULTS,kNN,DistM,k,Ncounted{1,i},querySIFTsNum{1,i},ixs,ImgIndx,nb  );
            ScoresTotal(:,2)=ScoresTotal(:,2)+scores(:,4);
            % display('aaaaaaaaaaaaaa');
        end
    end
    toc;
    
    answ=8;
    [~, I] = sort((-ScoresTotal(:,2)));
%     idx=I(1:answ);
    output3=ScoresTotal(I,:);
    display('output the results...');
    abc=output3(1:answ,1);
    display('abc generated...');
    result = sprintf('/mnt/Images/%s\n', filenames{abc});
    display('results sent...');
    display(result);
    toc;
end
















