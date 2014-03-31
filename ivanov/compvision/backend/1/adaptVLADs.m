N_VLAD_FILES = 100;
VLAD_DIRECTORY = '/mnt/Data/VLADs';

fprintf('Computing new means\n');
meanVLADs = single([]);
for dir=1:N_VLAD_FILES
    load(sprintf('%s/%d', VLAD_DIRECTORY, dir));
    meanVLADs(:, dir) = mean(encodings, 2);
    fprintf('%d ', dir);
end
adaptedCenters = mean(meanVLADs, 2);
save([VLAD_DIRECTORY, '/clustersAdaptedCenters'], 'adaptedCenters');
fprintf('\nDone!\n');