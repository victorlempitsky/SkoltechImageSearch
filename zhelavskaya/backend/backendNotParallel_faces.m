function ranks = backendNotParallel_faces (query, ...
    model, VV, means, covariances, priors, W, upd_FVs_dataset)

% I Read image

try
    img = imread(query);
catch err
    ranks = 0;%spalloc(1, N, 1);
%     ranks(N) = 0;
    fprintf('Couldn''t open img "%s"\n', query);
    return
end


% II Crop to get faces

% faces = cell array - element - 3d array of image
faces = extractfaces(img, model);

if isempty(faces)
    fprintf('No faces found for img "%s"\n', query);
    return
end


% III Get descriptor

sifts = get_sifts(faces(1));

sifts_pca = apply_pca(VV, sifts, faces(1));

FVs = encode_fvs(means, covariances, priors, sifts_pca);

upd_FVs = apply_metrics(FVs, W);


% IV Compare to all data

distances = sqrt(sum((upd_FVs_dataset - repmat(upd_FVs, 1, size(upd_FVs_dataset, 2))) ^ 2));


% V Rank

[distances, ix] = sort(distances);

ranks = 1 ./ distances;

% ranks = spalloc(1, N, N_RESULTS);
% ranks( ix(1:N_RESULTS) ) = 1./distances(1:N_RESULTS);
% ranks( N ) = max(ranks(N), 1e-9); % workaround wrong dim size



