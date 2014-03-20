N_VLAD_FILES = 100;
VLAD_DIRECTORY = '/mnt/Data/VLADs';

filenamesAll = {};
for dir=1:N_VLAD_FILES
    load(sprintf('%s/filenames%d', VLAD_DIRECTORY, dir));
    filenamesAll = [filenamesAll, filenames];
end

filenames = filenamesAll;

save([VLAD_DIRECTORY, '/filenamesAll'], 'filenames');