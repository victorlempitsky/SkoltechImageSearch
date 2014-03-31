function [ pqpca, pca, vlad, sifts ] = getPqPcaVladFromImg( img, ...
    clusters, adaptedCenters, coeff, pqClusters, pqRotation )
%GETPQ Summary of this function goes here
%   Detailed explanation goes here

[ vlad, sifts ] = getVLADFromImg( img, clusters ); % get vlads
vlad = vlad - adaptedCenters; % adapt centers
pca = coeff * vlad; % get principal components
pcaRot = pqRotation*pca; % rotate by our random rotation
pqpca = pq( pqClusters, pcaRot ); % get product quantization

end

