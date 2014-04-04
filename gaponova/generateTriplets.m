function [q,p,n] = generateTriplets(W,X,k,indCl,indNeg,allCl,cl)
% this function generate triplets for given query point (q), p - is a
% k-nearest neighbors of q, n - k*2 negative examples
ind=indCl.(allCl{cl});
q=randsample(indCl.(allCl{cl}),1);
p=findNeighbors(W,X,k,ind,q);
n=findImpostors(indNeg,allCl{cl},k);
end

