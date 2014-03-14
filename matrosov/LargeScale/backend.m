% usage: "query='imgs/1/123.456.jpg'; output='output.txt'; backend;"

MAX_IMG_SIZE = 1024;

tic;

if ~exist('pqPcaEncodings')
    load ('/mnt/Data/VLADs/filenamesAll')
    load ('/mnt/Data/VLADs/clusters')
    load ('/mnt/Data/VLADs/clustersAdaptedCenters')
    load ('/mnt/Data/VLADs/pca')
    load ('/mnt/Data/VLADs/pqPcaEncodings')
    load ('/mnt/Data/VLADs/pqClusters')
    load ('/mnt/Data/VLADs/pqDistances')
    load ('/mnt/Data/VLADs/pqRotation')
end

toc;

img = imread(query);

% resize img if necessary
sz = size(img);
sz = sz([1,2]);
if sz(1)>MAX_IMG_SIZE || sz(1)>MAX_IMG_SIZE
    img = imresize(img, 1024.0/max(sz));
end

% get encoding
[ pqpca, pca, vlad, sifts ] = getPqPcaVladFromImg( img, ...
clusters, adaptedCenters, coeff, pqClusters, pqRotation );

% measure distances
distances = pq_alldist(pqpca, pqPcaEncodings, pqDistances);

% rank
[distances,ix] = sort(distances);

toc;

% write result
fd = fopen(output, 'w');
fprintf(fd, '/mnt/Images/%s\n', filenames{ix(1:5)});
fclose(fd);
