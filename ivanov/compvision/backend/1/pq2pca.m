function [ pca ] = pq2pca( pq, pqClusters )
% converts pq to pca

pca = [];

for i=1:16
    pca = [pca; pqClusters(:, int32(pq(i,:))+1, i)];
end

end

