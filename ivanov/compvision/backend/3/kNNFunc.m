function [ kNN,DistM ] = kNNFunc( k, RankingSIFTs, SIFTsArray, N )
% returns k-NN set sorted by increasing eucledian distance
kNN=zeros(N,k);
DistM=zeros(N,k);
for i=1:N
    qSIFT=RankingSIFTs(:,i);
    ttt = bsxfun(@minus,SIFTsArray,qSIFT); 
%     tt = sum(ttt.^2);
    tt = sum(abs(ttt));
    [~, I] = sort(tt);
    NN=I(1:k);
    kNN(i,:)=NN;
    DistM(i,:)=tt(NN);
    
end


end

