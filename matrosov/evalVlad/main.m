if ~exist('sifts')
    addpath('../common');
    %load('/mnt/Data/SIFTs/Holidays');
    load('../data/rootsifts');
    %load('../data/clusterizations');
    load('../data/rootclusterizations');
    load('../data/holidaysLabels');
end

mAPs=[];

for i=1:numel(clusterizations)
    encodings = computeEncodings(sifts, clusterizations{i});

    mAP = getMAP(labels, encodings);
    mAPs(i) = mAP;
    
    save('mAPS', 'mAPs');
    fprintf('Clusterization #%d is done! mAP=%.4f\n', i, mAP);
end