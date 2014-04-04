function [nearest,dist] = findNeighbors(W,X,k,ind,ex)
% This function returns k-nearest neighbors for query point (ex). There are
% two ways to do it. We can use exhaustive list of all positive examples of
% each class to compute distances and choose the smallest. It can be
% computationally expensive. Or we can just randomly choose some subset of
% positive examples (in order to do that, uncomment the line 11 and
% comment line 12)

% k should be much less that number of examples in the class

% p=randsample(ind,k+3);
p=ind;
dist=computeDistM(W,X(:,p),X(:,ex));
[dist,i]=sort(dist);

if p(i(1))==ex
    nearest=p(i(2:k+1));
    dist=dist(2:k+1);
else
    nearest=p(i(1:k));
    dist=dist(1:k);
end

end

