N_VLAD_FILES = 100;
VLAD_DIRECTORY = '/mnt/Data/VLADs';

load([VLAD_DIRECTORY, '/clustersAdaptedCenters']);
load([VLAD_DIRECTORY, '/pca']);

for dir=1:N_VLAD_FILES
    load(sprintf('%s/%d', VLAD_DIRECTORY, dir));
    encodings = bsxfun(@minus, encodings, adaptedCenters);
    encodings = coeff * encodings;
    save(sprintf('%s/pcaVLADs%d', VLAD_DIRECTORY, dir), 'encodings');
    fprintf('%d ', dir);
end

fprintf('\nDone!\n');