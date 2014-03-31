%% Get 1M SIFTs
idxs = randsample(size(Imgs, 1), 100000);

sifts = zeros(128, 1000000);

for i = 1:100000
    try
        sift = load(Imgs(idxs(i)).name, '-mat', 'd');
        sifts(:,(i-1)*10+1:i*10) = vl_colsubset(sift.d, 10);
    catch exc
    end
end

save('rootsifts.mat', 'sifts');

disp('Sifts done.');

%% Constracting 30k vocabulary
[C_30, A_30] = vl_kmeans(sifts, 30000);
save('vocabulary_30k_root.mat', 'C_30', 'A_30');

disp('Voc30k done.');

%% Constracting 100k vocabulary
[C_100, A_100] = vl_kmeans(sifts, 100000);
save('vocabulary_100k_root.mat', 'C_100', 'A_100');

disp('Voc100k done.');





