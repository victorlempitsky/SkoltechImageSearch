function [FVs] = encode_fvs(means, covariances, priors, file_people)

fid = fopen(file_people);
num_people = textscan(fid, '%d \n');
num_people = num_people{1};
people = textscan(fid, '%s\t%d\n', num_people);
fclose(fid);

% face_region_set = cell(num_people, 1);
% peopleToFV = cell(num_people, 1);
k = 1;
% m = 1;
% wrong = '';

FVs = cell(1000, 1);


for i = 1 : num_people,
    i
    folder_name = ['/mnt/sifts_faces_pcas/' people{1}{i}];
    cd(folder_name);
    
    D = dir([folder_name, '/*.mat']);
%     numFiles = length(D(not([D.isdir])));
    
%     j = 0;
    while ~isempty(D)
%         j = j + 1;
        
        load(D(1).name)
        
        FVs{k} = vl_fisher(sift_features_dense_pca{1}, means, covariances, priors, 'Improved');
        
        D(1) = [];
       
        k = k + 1;
    end
    
end

