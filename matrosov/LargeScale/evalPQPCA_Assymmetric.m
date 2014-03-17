load('/mnt/Data/VLADs/pqPcaEncodingsAllPlusHolidays');
load('/mnt/Data/VLADs/labelsAllPlusHolidays');
load('/mnt/Data/VLADs/pqClusters');
load('/mnt/Data/VLADs/pqRotation');
load('/mnt/Data/VLADs/pcaVLADs_Holidays');

APs=[];

tic;

for i=1:1491
    pca = pqRotation * encodings(:,i);
    
    pqDistances = zeros(256,16);
    for j=1:16
        ix = (j-1)*16+1 : j*16;
        pqDistances(:,j) = vl_alldist2(pca(ix,:), pqClusters(:,:,j));
    end
    
    subDistances = zeros(size(pqPcaEncodings,2), 16);
    pq = int32(pqPcaEncodings)+1;
    for j=1:16
        subDistances(:,j) = pqDistances(pq(j,:), j);
    end

    distances = sum(subDistances, 2);

    [recall, precision] = vl_pr(labels(i,:)*2-1, -distances);
    AP = trapz(recall, precision);
    
    APs(i) = AP;
    
    fprintf('%d:%.4f\n', i, AP);
end

fprintf('\nMean = %.4f\n', mean(APs));

toc;