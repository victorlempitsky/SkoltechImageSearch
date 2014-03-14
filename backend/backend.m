% usage: "query='imgs/1/123.456.jpg'; backend;"

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

img = imread(query);

[ pqpca, pca, vlad, sifts ] = getPqPcaVladFromImg( img, ...
clusters, adaptedCenters, coeff, pqClusters, pqRotation );

distances = pq_alldist(pqpca, pqPcaEncodings, pqDistances);

[distances,ix] = sort(distances);

fd = fopen('output.txt', 'w');
fprintf(fd, '/mnt/Images/%s\n', filenames{ix(1:5)});
fclose(fd);
