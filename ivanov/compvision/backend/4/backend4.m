% usage: "query='imgs/1/123.456.jpg'; output='output.txt'; backend; result"

% tic;
if ~exist('filenames1', 'var')
init;
load('/home/urman/FacesModule/facefeats/model.mat')
load('/mnt/sifts_matrices/pca2.mat')
load('/mnt/sifts_matrices/gmms2.mat')
% %        load('/mnt/sifts_matrices/filenames.mat')
load('/mnt/sifts_matrices/filenames_cropped.mat')
% load('/mnt/sifts_matrices/Winit.mat')
load('/mnt/sifts_matrices/upd_FV_set_new.mat')
load('/mnt/sifts_matrices/metrics.mat')
end
%query = '/mnt/DropboxForLFW/Dropbox/CV project/lfw/Aaron_Peirsol/Aaron_Peirsol_0001.jpg';
%queries = {query query};%strsplit(query, '\n');
queries = strsplit(query, '\n');
W = W(:, :, 1);
n_queries = numel(queries) -1;
ranks = [];
ix = [];

for i=1:n_queries
    try
        [ranks(i, :), ix(i, :)] = backendNotParallel_faces(queries{i}, ...
            model, VV, means, covariances, priors, W, updFVs_set);
        
    catch err
        fprintf('Couldn''t process img "%s"\n', queries{i});
    end
end

ix2 = [];

ranks = ranks(:, 1 : 8);
ix = ix(:, 1 : 80);
ix(ix==0) =[];
ix = ix(1:72);
[c, ind] = max(ranks);
% [ranks2, ix2] = sort(max(ranks), 'descend');
% for i = 1 : 8,
%     ix2(i) = ix(ind(i), ix2(i));
% end
% [ranks,ix] = sort(ranks, 'descend');

fprintf('Processed %d images.\n', n_queries);

% write result

%result = sprintf('/mnt/Images/%s\n', filenames{ix(1:10)});
result = sprintf('/mnt/CroppedFaces/%s\n', filenames1{ix'});
% result = [result1 result2 result2 result2 result2 result2 result2 result2 result2];

