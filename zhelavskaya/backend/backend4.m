% usage: "query='imgs/1/123.456.jpg'; output='output.txt'; backend; result"

N_RESULTS = 10;

tic;

init;
load('/mnt/sifts_matrices/Winit')
load('/home/urman/FacesModule/facefeats/model.mat')
load('/mnt/sifts_matrices/pca2.mat')
load('/mnt/sifts_matrices/gmms2.mat')
load('/mnt/sifts_matrices/metrics.mat')
%        load('/mnt/sifts_matrices/filenames.mat')
load('/mnt/sifts_matrices/filenames_cropped.mat')


queries = strsplit(query, '\n');

n_queries = numel(queries)-1;
ranks = spalloc(n_queries, size(pqPcaEncodings,2), n_queries*N_RESULTS);

parfor i=1:n_queries
    try
        ranks(i,:) = backendNotParallel_faces (queries{i}, ...
            model, VV, means, covariances, priors, W, upd_FVs_dataset)
        
    catch err
        fprintf('Couldn''t process img "%s"\n', queries{i});
    end
end

ranks = full(ranks);
[ranks,ix] = sort(max(ranks), 'descend');
% [ranks,ix] = sort(ranks, 'descend');

fprintf('Processed %d images.\n', n_queries);
toc;

% write result

%result = sprintf('/mnt/Images/%s\n', filenames{ix(1:10)});
result = sprintf('/mnt/CroppedFaces/%s\n', filenames{ix(1:10)});
