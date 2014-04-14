function [sifts_dense_for_pca] = get_random_sifts(file_people)

fid = fopen(file_people);
num_people = textscan(fid, '%d \n');
num_people = num_people{1};
people = textscan(fid, '%s\t%d\n', num_people);
fclose(fid);

k = 1;

n = 315372600;
rp = randperm(n, 100000);
rp = sort(rp);
l_sift = 36350;
num_v = 8676;

sifts_dense_for_pca.descrs = cell(num_v, 1);
sifts_dense_for_pca.frames = cell(num_v, 1);


for i = 1 : num_people,
    i
    folder_name = ['/mnt/sifts_faces/' people{1}{i}];
    cd(folder_name);
    
    D = dir([folder_name, '/*.mat']);

    while ~isempty(D)
        
        load(D(1).name)
        
        ind = rp(rp >= (k - 1) * l_sift + 1 & rp < k * l_sift) - (k - 1) * l_sift;
        
        sifts_dense_for_pca.descrs{k} = sift_features_dense.descrs{1}(:, ind);
        sifts_dense_for_pca.frames{k} = sift_features_dense.frames{1}(1 : 2, ind);
        
        D(1) = [];
       
        k = k + 1;
    end
    
end



