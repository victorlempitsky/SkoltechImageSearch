function [ kNN,DistM ] = kNNFuncTrees( k, RankingSIFTs, trees, N )
% returns k-NN set sorted by increasing eucledian distance
kNN=zeros(N,k);
DistM=zeros(N,k);
for i=1:N
    tic
    qSIFT=RankingSIFTs(:,i);
    [ results ] = searchInTrees( single(qSIFT)', trees, k );
    NN=cell2mat(results(:,2)');
    kNN(i,:)=NN;
    DistM(i,:)=cell2mat(results(:,3)');
    toc
%     display('aaaaaaaaaa');
end


end



