load('/mnt/Data/VLADs/filenamesAll');
fn_1M = filenames;
load('/mnt/Data/VLADs/filenames_Holidays');
for i=1:1491
    q=filenames{i};
    filenames{i} = q(13:end);
end
filenames = [filenames, fn_1M];
save('/mnt/Data/VLADs/filenamesAllPlusHolidays', 'filenames');

load('/mnt/Data/VLADs/pqPcaEncodings');
enc_1M = pqPcaEncodings;
load('/mnt/Data/VLADs/pqPcaEncodings_Holydays');
pqPcaEncodings = [pqPcaEncodings, enc_1M];
save('/mnt/Data/VLADs/pqPcaEncodingsAllPlusHolidays', 'pqPcaEncodings');

%load('/mnt/Data/VLADs/labelsAllPlusHolidays');

N_VLAD_FILES = 100;
VLAD_DIRECTORY = '/mnt/Data/VLADs';

load([VLAD_DIRECTORY,'/pcaVLADs_Holidays']);

encodingsAll = encodings;

for dir=1:N_VLAD_FILES
    load(sprintf('%s/pcaVLADs%d', VLAD_DIRECTORY, dir));
    encodingsAll = [encodingsAll, encodings];
    fprintf('%d ', dir);
end

encodings = encodingsAll;

save([VLAD_DIRECTORY, '/pcaEncodingsAllPlusHolidays'], 'encodings');
fprintf('\nDone!\n');
