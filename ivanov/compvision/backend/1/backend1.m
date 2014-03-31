% usage: "query='imgs/1/123.456.jpg'; output='output.txt'; backend; result"

N_RESULTS = 8;

MULTIPLE_QUERIES = 1;

tic;

if ~exist('filenames', 'var')
      %load ('/mnt/Data/VLADs/pqPcaVladDataAsClassAll')
    load ('/mnt/Data/VLADs/filenamesAll')
    load ('/mnt/Data/VLADs/clusters')
    load ('/mnt/Data/VLADs/clustersAdaptedCenters')
    load ('/mnt/Data/VLADs/pca')
    load ('/mnt/Data/VLADs/pqPcaEncodings')
    load ('/mnt/Data/VLADs/pcaEncodingsAll.mat')
    load ('/mnt/Data/VLADs/pqClusters')
    load ('/mnt/Data/VLADs/pqDistances')
    load ('/mnt/Data/VLADs/pqRotation')
    pqPcaVladData = PqPcaVladData(pqPcaEncodings, encodings, clusters,...
       adaptedCenters, coeff, pqClusters, pqRotation, pqDistances, N_RESULTS);
    toc;
end

queries = strsplit(query, '\n');

n_queries = numel(queries)-1;
%ranks = spalloc(n_queries, size(pqPcaEncodings,2), n_queries*N_RESULTS);

if MULTIPLE_QUERIES
    ranks = [];
    parfor i=1:n_queries
        try
            ranks(i,:) = backendNotParallel (queries{i}, pqPcaVladData);
        catch err
            ranks(i,:) = zeros(numel(filenames));
            fprintf('Couldn''t process img "%s"\n', queries{i});
        end
    end
    
    ixs = [];
    for i=1:size(ranks,1)
        [~,ix] = sort(ranks(i,:), 'descend');
        ixs(end+1,:) = ix(1:N_RESULTS);
    end
    if size(ranks,1)>1
        [ranks,ix] = sort(mean(ranks), 'descend');
    else
        [ranks,ix] = sort(ranks, 'descend');
    end
    ixs = [ix(1:N_RESULTS)';ixs(:)]; % combine
else
    try
        ranks = backendNotParallel (queries{1}, pqPcaVladData);
        [ranks,ixs] = sort(ranks, 'descend');
        ixs = ixs(1:N_RESULTS);
    catch err
        fprintf('Couldn''t process img "%s"\n', queries{i});
    end
end

fprintf('Processed %d images.\n', n_queries);
toc;

% write result
result = sprintf('/mnt/Images/%s\n', filenames{ixs});
