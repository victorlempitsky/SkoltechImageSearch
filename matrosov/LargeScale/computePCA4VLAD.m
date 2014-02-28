load ('/mnt/Data/VLADs/1')

pcaVecs = pca(encodings');

pcaReduced = pcaVecs(256,:);