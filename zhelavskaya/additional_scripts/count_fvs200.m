
load('/mnt/sifts_matrices/gmms2.mat')

for i = 1 : num_people,
%     i
    folder_name = ['/mnt/CroppedFaces_densesifts/' num2str(i)];
    cd(folder_name);
    
    D = dir([folder_name, '/*.mat']);
    
    name = ['/mnt/CroppedFaces_FVs/', num2str(i)];
    mkdir(name)
    
    while ~isempty(D)
        folder_name = ['/mnt/CroppedFaces_densesifts/', num2str(i)];
        cd(folder_name);
    
        load(D(1).name)
        
        folder_name = ['/home/zhelavskaya/face_project/'];
        cd(folder_name);
        
        FVs = vl_fisher(sift_features_dense_pca{1}, means, covariances, priors, 'Improved');

        
        name = ['/mnt/CroppedFaces_FVs/', num2str(i), '/', D(1).name];
        save(name, 'FVs')
        
        D(1) = [];

    end
    
end




