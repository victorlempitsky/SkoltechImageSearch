
load('/mnt/sifts_matrices/pca2.mat')

for i = 1 : num_people,
%     i
    folder_name = ['/mnt/CroppedFaces_sifts/' num2str(i)];
    cd(folder_name);
    
    D = dir([folder_name, '/*.mat']);
    
    name = ['/mnt/CroppedFaces_densesifts/', num2str(i)];
    mkdir(name)
    
    while ~isempty(D)
        folder_name = ['/mnt/CroppedFaces_sifts/', num2str(i)];
        cd(folder_name);
    
        load(D(1).name)
        
        folder_name = ['/home/zhelavskaya/face_project/'];
        cd(folder_name);
        
        [sift_features_dense_pca, ~] = apply_pca(VV, sift_features_dense(1));

        
        
        name = ['/mnt/CroppedFaces_densesifts/', num2str(i), '/', D(1).name];
        save(name, 'sift_features_dense_pca')
        
        D(1) = [];
    
    end
    
end


