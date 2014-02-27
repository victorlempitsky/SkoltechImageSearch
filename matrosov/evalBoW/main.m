if ~exist('sifts')
    addpath('../common');
    load('../data/rootsifts');
    %load('mnt/Data/SIFTs/Holidays');
    load('../data/rootclusterizations256');
    load('../data/holidaysLabels');
end

mAPs = [];

for i=1:numel(clusterizations)
    encodings = computeEncodings(sifts, clusterizations{i});
    
    encodings = tf_normalize(encodings);
    
    for j=1:size(encodings,2)
        v = encodings(:,j);
        v = v/norm(v);
        encodings(:,j) = v;
    end
    
    mAP = getMAP(labels, encodings);
    mAPs(i) = mAP;
     
    fprintf('Clusterization #%d is done! mAP=%.4f\n', i, mAP);
end

fprintf('%.4f/%.4f+%.4f/%.4f\n', min(mAPs), mean(mAPs), std(mAPs), max(mAPs));
