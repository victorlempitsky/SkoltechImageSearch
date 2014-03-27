function ranks = backendNotParallel (query, ...
    pqPcaEncodings, encodings, clusters, adaptedCenters, coeff, pqClusters, pqRotation, N_RESULTS)

MAX_IMG_SIZE = 1024;
N = size(pqPcaEncodings,2);

try
    img = imread(query);
catch err
    ranks = spalloc(1, N, 1);
    ranks(N) = 0;
    fprintf('Couldn''t open img "%s"\n', query);
    return
end

% resize img if necessary
sz = size(img);
sz = sz([1,2]);
if sz(1)>MAX_IMG_SIZE || sz(1)>MAX_IMG_SIZE
    img = imresize(img, 1024.0/max(sz));
end

% get encoding
[ pqpca, pca, vlad, sifts ] = getPqPcaVladFromImg( img, ...
clusters, adaptedCenters, coeff, pqClusters, pqRotation );

% measure distances - symmetric
%distances = pq_alldist(pqpca, pqPcaEncodings, pqDistances);

% measure distances - assymmetric
pqDistances = zeros(256,16);
for j=1:16
    ix = (j-1)*16+1 : j*16;
    pqDistances(:,j) = vl_alldist2(pca(ix,:), pqClusters(:,:,j));
end

subDistances = zeros(N, 16);
pq = int32(pqPcaEncodings)+1;
for j=1:16
    subDistances(:,j) = pqDistances(pq(j,:), j);
end

distances = sum(subDistances, 2);

[~,ix] = sort(distances);

encs = encodings(:,ix(1:1000));
distances2 = vl_alldist2(pca, encs);

[dd, ix2] = sort(distances2);

ranks = zeros(size(distances));
ranks(ix(ix2(1:N_RESULTS))) = 1./dd(1:N_RESULTS);

%distances = vl_alldist2(pca, pcaEncodings);

% rank
%[distances,ix] = sort(distances);

%ranks = 1./distances; 
%ranks = spalloc(1, N, N_RESULTS);
%ranks( ix(1:N_RESULTS) ) = 1./distances(1:N_RESULTS);
%ranks( N ) = max(ranks(N), 1e-9); % workaround wrong dim size

end

