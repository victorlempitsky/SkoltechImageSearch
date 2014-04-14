function [means, covariances, priors] = train_gmms(Y)

numClusters = 512;
[means, covariances, priors] = vl_gmm(Y, numClusters);
% load('/mnt/sifts_matrices/gmms.mat')

