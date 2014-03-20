N_VLAD_FILES = 100;
VLAD_DIRECTORY = '/mnt/Data/VLADs';

load([VLAD_DIRECTORY, '/pqClusters']);
load([VLAD_DIRECTORY, '/pqRotation']);

pqPcaEncodings = uint8([]);

for dir=1:N_VLAD_FILES
    load(sprintf('%s/pcaVLADs%d', VLAD_DIRECTORY, dir));
    
    encodings = pqRotation * encodings;
    pqpca = pq( pqClusters, encodings );
    pqPcaEncodings = [pqPcaEncodings, pqpca];
    
    fprintf('%d ', dir);
end

save([VLAD_DIRECTORY, '/pqPcaEncodings'], 'pqPcaEncodings');
fprintf('\nDone!\n');
