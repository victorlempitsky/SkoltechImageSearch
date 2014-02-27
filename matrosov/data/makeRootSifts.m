load('/mnt/Data/SIFTs/Holidays');

for i=1:numel(sifts)
    d = sifts{i};
    d = uint8(sqrt(single(d))*16);
    
    sifts{i} = d;
end

save('rootsifts', 'sifts');