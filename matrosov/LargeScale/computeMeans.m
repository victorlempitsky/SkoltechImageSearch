load('/mnt/Data/arutar/HASH/rootsifts.mat');

N = size(sifts, 2);

ix = randsample(1:N, 100000);

d = single(sifts(:, ix));
d = bsxfun(@times, d, 1./sum(abs(d)));
d = sqrt(d);

clusters = vl_ikmeans(uint8(d*450), 64);
clusters = single(clusters)/450;

save('/mnt/Data/VLADs/clusters', 'clusters');