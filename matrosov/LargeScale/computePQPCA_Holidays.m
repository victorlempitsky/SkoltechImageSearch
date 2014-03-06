VLAD_DIRECTORY = '/mnt/Data/VLADs';

load('/mnt/Data/RootSIFTs/Holidays');
load([VLAD_DIRECTORY,'/clusters']);

encodings = single([]);

for i=1:numel(sifts);
    encodings(:,end+1) = getVLAD(sifts{i}, clusters);
end
save([VLAD_DIRECTORY, '/Holidays'], 'encodings');
fprintf('VLADs are computed!\n');

load([VLAD_DIRECTORY, '/pqClusters']);
load([VLAD_DIRECTORY, '/pqRotation']);
load([VLAD_DIRECTORY, '/clustersAdaptedCenters']);
load([VLAD_DIRECTORY, '/pca']);

encodings = bsxfun(@minus, encodings, adaptedCenters);
encodings = coeff * encodings;
save([VLAD_DIRECTORY, '/pcaVLADs_Holidays'], 'encodings');

pqPcaEncodings = uint8([]);

encodings = pqRotation * encodings;
pqpca = pq( pqClusters, encodings );
pqPcaEncodings = [pqPcaEncodings, pqpca];

save([VLAD_DIRECTORY, '/pqPcaEncodings_Holydays'], 'pqPcaEncodings');
fprintf('Done!\n');
