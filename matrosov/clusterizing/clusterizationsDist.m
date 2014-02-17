function [ dist ] = clusterizationsDist( cl1, cl2 )
% cl1 and cl2 - two clusterizations - matrices 128x64

N = size(cl1, 2);

d = vl_alldist2(cl1, cl2);
[~, ix] = sort(d(:));

rows = ones(N,1);
cols = ones(N,1);
nnz = 0;
dist = 0;

for ind=ix'
    [i,j]=ind2sub(size(d), ind);
    if rows(i) && cols(j)
        rows(i) = 0;
        cols(j) = 0;
        nnz = nnz+1;
        dist = dist + d(ind);
    end
    if nnz==N
        break; % stop condition
    end
end

dist = sqrt(double(dist));

end

