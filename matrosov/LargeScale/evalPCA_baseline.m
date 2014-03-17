load('/mnt/Data/VLADs/pcaEncodingsAllPlusHolidays');
load('/mnt/Data/VLADs/labelsAllPlusHolidays');

APs=[];

tic;

for i=1:1491
    distances = vl_alldist2(encodings(:,i), encodings);

    [recall, precision] = vl_pr(labels(i,:)*2-1, -distances);
    AP = trapz(recall, precision);
    
    APs(i) = AP;
    
    fprintf('%d:%.4f\n', i, AP);
end

fprintf('\nMean = %.4f\n', mean(APs));

toc