%  init;
%         load('/home/urman/FacesModule/facefeats/model.mat')
%         load('/mnt/sifts_matrices/pca2.mat')
%         load('/mnt/sifts_matrices/gmms2.mat')
% %         load('/mnt/sifts_matrices/metrics.mat')
% % %        load('/mnt/sifts_matrices/filenames.mat')
% 	load('/mnt/sifts_matrices/filenames_cropped.mat')
%     load('/mnt/sifts_matrices/Winit.mat')
% load('/mnt/sifts_matrices/upd_FVs_set.mat')
%     load('/mnt/sifts_matrices/FVs2_1.mat')
%     load('/mnt/sifts_matrices/FVs2_2.mat')
% W = rand(67584, 128);

query = '/mnt/DropboxForLFW/Dropbox/CV project/lfw/Aaron_Peirsol/Aaron_Peirsol_0001.jpg';

% W = W_init;

ranks = backendNotParallel_faces (query, ...
    model, VV, means, covariances, priors, W, upd_FVs_dataset);