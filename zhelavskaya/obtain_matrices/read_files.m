function [scannedData_pos, scannedData_neg, scannedData_people, num_samp, num_people] = read_files(file_pairs, file_people)

% file_pairs = '/Users/iris_sk/Documents/Skoltech/Classes/Term2/Quarter1/CV/Face_recognition_project/croppedfaces/pairsDevTrain.txt';
% file_people = '/Users/iris_sk/Documents/Skoltech/Classes/Term2/Quarter1/CV/Face_recognition_project/croppedfaces/peopleDevTrain.txt';

% Need to add a check for existance

fid = fopen(file_pairs);
num_samp = textscan(fid, '%d \n');
scannedData_pos = textscan(fid, '%s\t%d\t%d\n', num_samp{1});
scannedData_neg = textscan(fid, '%s\t%d\t%s\t%d\n', num_samp{1});
fclose(fid);

fid = fopen(file_people);
num_people = textscan(fid, '%d \n');
scannedData_people = textscan(fid, '%s\t%d\n', num_people{1});
fclose(fid);
