function [ indexes ] = selectClusterizations( D, k )
% D - matrix of distances
% k - number of elements that we need
% indexes - points such that sum(d_{i,j}) -> min

maxD = max(D);
[~, ix] = sort(maxD);

indexes = ix(end-k+1:end);

end

