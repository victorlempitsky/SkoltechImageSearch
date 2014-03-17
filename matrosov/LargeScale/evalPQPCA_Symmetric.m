load('/mnt/Data/VLADs/pqPcaEncodingsAllPlusHolidays');
load('/mnt/Data/VLADs/labelsAllPlusHolidays');
load ('/mnt/Data/VLADs/pqDistances')
addpath('../common');

APs=[];

tic;

for i=1:1491
    distances = pq_alldist(pqPcaEncodings(:,i), pqPcaEncodings, pqDistances);

    [recall, precision] = vl_pr(labels(i,:)*2-1, -distances);
    AP = trapz(recall, precision);
    
    APs(i) = AP;
    
    fprintf('%d:%.4f\n', i, AP);
end

fprintf('\nMean = %.4f\n', mean(APs));

toc;