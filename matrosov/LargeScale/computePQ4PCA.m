N_QUANTS_PER_SUBSPACE = 256;
VLAD_DIRECTORY = '/mnt/Data/VLADs';

load ([VLAD_DIRECTORY, '/pcaVLADs1']);

% deal only with pca encodings size of 256
assert(size(encodings, 1) == 256);

pqClusters = [];
pqDistances = [];

for i=1:16
    ix = (i-1)*16 + (1:16);
    C = vl_kmeans(encodings( ix,: ),  N_QUANTS_PER_SUBSPACE);
    pqClusters(:,:,i) = C;
    pqDistances(:,:,i) = vl_alldist2(C, C);
end

pqClusters = single(pqClusters);
pqDistances = single(pqDistances);

save([VLAD_DIRECTORY, '/pqClusters'], 'pqClusters');
save([VLAD_DIRECTORY, '/pqDistances'], 'pqDistances');


% random rotation
[pqRotation,~] = qr(randn(256));

save([VLAD_DIRECTORY, '/pqRotation'], 'pqRotation');