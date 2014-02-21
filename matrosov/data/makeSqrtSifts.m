load('clusterizations');
load('/mnt/Data/SIFTs/Holidays');

for i=1:numel(sifts)
    d = sifts{i};
    d = single(d)-127;
    d = sign(d).*sqrt(abs(d));
    d = int8(d*12);
    
    sifts{i} = d;
end

for i=1:numel(clusterizations)
    d = clusterizations{i};
    d = single(d)-127;
    d = sign(d).*sqrt(abs(d));
    d = int8(d*12);
    
    clusterizations{i} = d;
end

save('rootsifts', 'sifts');
save('rootclusterizations', 'clusterizations');