if ~exist('sifts')
    load('clusterizations');
    load('../data/sifts');
    hlist = holidaysList();
end

N = numel(hlist);
mAPs=[];

% true labels
labels = zeros(N);
for i=1:N
    for j=max(1,i-20):min(i+20,N)
        si = hlist{i};
        sj = hlist{j};
        labels(i,j) = strcmp(si(end-9:end-6), sj(end-9:end-6));
    end
end

for i=1:numel(clusterizations)
    encodings = computeEncodings(sifts, clusterizations{i});
    distances = vl_alldist2(encodings, encodings);
    [recall, precision] = vl_pr(labels(:)-0.5, -distances(:));
    mAP = trapz(recall, precision);
    
    mAPs(i)=mAP;
    save('mAPS', 'mAPs');
    fprintf('Clusterization #%d is done! mAP=%.4f', i, mAP);
end