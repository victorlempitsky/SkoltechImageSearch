if ~exist('pqPcaEncodings')
    %load ('/mnt/Data/VLADs/filenamesAll')
    load ('/mnt/Data/VLADs/filenamesAllPlusHolidays')
    load ('/mnt/Data/VLADs/clusters')
    load ('/mnt/Data/VLADs/clustersAdaptedCenters')
    load ('/mnt/Data/VLADs/pca')
    %load ('/mnt/Data/VLADs/pqPcaEncodings')
    load ('/mnt/Data/VLADs/pqPcaEncodingsAllPlusHolidays')
    load ('/mnt/Data/VLADs/pqClusters')
    load ('/mnt/Data/VLADs/pqDistances')
    load ('/mnt/Data/VLADs/pqRotation')
end

N = 1491;%numel(filenames);
W = 4;
H = 3;

while 1
    tic
    
    %fname = filenames{ceil(N*rand())};
    fname = filenames{705};
    img = imread(['/mnt/Images/', fname]);
    
    [ pqpca, pca, vlad, sifts ] = getPqPcaVladFromImg( img, ...
    clusters, adaptedCenters, coeff, pqClusters, pqRotation );

    distances = pq_alldist(pqpca, pqPcaEncodings, pqDistances);
    
    [distances,ix] = sort(distances);
    
    toc
    
    subplot(H,W,1); imshow(img);
    for i=2:W*H
        img = imread(['/mnt/Images/', filenames{ix(i-1)}]);
        subplot(H,W,i); imshow(img);
    end
    
    pause(1);
end