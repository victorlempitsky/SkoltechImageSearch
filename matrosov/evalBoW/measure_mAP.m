if ~exist('sifts')
    load('../data/clusterizations1024');
    load('/mnt/Data/SIFTs/Holidays');
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
    encodings = tf_normalize(encodings);
    for e=1:size(encodings,1)
        v = encodings(:,e);
        encodings(:,e) = v/norm(v);
    end
    
    distances = vl_alldist2(encodings, encodings);
    [recall, precision] = vl_pr(labels(:)-0.5, -distances(:));
    
    mAP = trapz(recall, precision);
    mAPs(i)=mAP;
    
    save('mAPS', 'mAPs');
    fprintf('#%i mAP=%.4f\n', i, mAP);
end