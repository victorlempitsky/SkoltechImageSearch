if ~exist('sifts')
    %load('/mnt/Data/SIFTs/Holidays');
    load('../../sifts');
    load('../../clusterizations');
    load('holidaysLabels');
end

N = numel(hlist);
mAPs=[];

for i=1:numel(clusterizations)
    encodings = computeEncodings(sifts, clusterizations{i});

     mAP = getMAP(labels, encodings);
     mAPs(i) = mAP;
    
    save('mAPS', 'mAPs');
    fprintf('Clusterization #%d is done! mAP=%.4f\n', i, mAP);
end