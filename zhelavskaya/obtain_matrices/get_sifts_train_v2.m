function [face_region_set, peopleToFV] = get_sifts_train_v2(file_people)

fid = fopen(file_people);
num_people = textscan(fid, '%d \n');
num_people = num_people{1};
people = textscan(fid, '%s\t%d\n', num_people);
fclose(fid);

face_region_set = cell(num_people, 1);
peopleToFV = cell(num_people, 1);
k = 1;
m = 1;
wrong = '';

for i = 1 : num_people,
    i
    folder_name = ['/mnt/DropboxForLFW/Dropbox/CV project/lfw/' people{1}{i}];
    cd(folder_name);
    load([people{1}{i} '.mat'])
    
    D = dir([folder_name, '\*.jpg']);
    l = length(D(not([D.isdir])));
    
    name = ['/mnt/sifts_faces/', people{1}{i}];
    mkdir(name)
    
    j = 0;  
    while ~isempty(facesfromfolder)
        j = j + 1;
        I = rgb2gray(facesfromfolder{1});
        I = single(I);
        
        facesfromfolder(1) = [];
        
        face_region_set{k} = I;
        
        peopleToFV{k, 1} = people{1}{i};
        peopleToFV{k, 2} = {j};
        peopleToFV{k, 3} = {k};
        
        folder_name = ['/home/zhelavskaya/face_project/'];
        cd(folder_name);
        
        sift_features_dense = extract_sifts({I});
      
        name = ['/mnt/sifts_faces/', people{1}{i}, '/', people{1}{i}, '000', num2str(j), '.mat'];
        save(name, 'sift_features_dense')
        
        k = k + 1;
    end
    
    if (j ~= l)
        wrong{m} = people{1}{i};
        m = m + 1;
    end
    
end


