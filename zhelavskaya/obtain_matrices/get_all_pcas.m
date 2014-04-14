function [k] = get_all_pcas(VV, file_people)

fid = fopen(file_people);
num_people = textscan(fid, '%d \n');
num_people = num_people{1};
people = textscan(fid, '%s\t%d\n', num_people);
fclose(fid);


for i = 1 : num_people,
    i
    folder_name = ['/mnt/sifts_faces/' people{1}{i}];
    cd(folder_name);
    
    D = dir([folder_name, '/*.mat']);
%     numFiles = length(D(not([D.isdir])));
    
    j = 0;
    
    name = ['/mnt/sifts_faces_pcas/', people{1}{i}];
    mkdir(name)
    
    while ~isempty(D)
        j = j + 1;
        folder_name = ['/mnt/sifts_faces/' people{1}{i}];
        cd(folder_name);
    
        load(D(1).name)
        
        folder_name = ['/home/zhelavskaya/face_project/'];
        cd(folder_name);
        
        [sift_features_dense_pca, ~] = apply_pca(VV, sift_features_dense(1));

        D(1) = [];
        
        name = ['/mnt/sifts_faces_pcas/', people{1}{i}, '/', people{1}{i}, '000', num2str(j), '.mat'];
        save(name, 'sift_features_dense_pca')
        
%         k = k + 1;
    end
    
end


