load('sifts');

for i=1:numel(sifts)
    d = sifts{i};
    
    d = single(d);
    d = bsxfun(@times, d, 1./sum(abs(d)));
    d = sqrt(d);
    
    sifts{i} = d;
end

save('sqrtSifts', 'sifts', '-v7.3');