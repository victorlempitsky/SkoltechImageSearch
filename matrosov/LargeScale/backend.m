% usage: "query='imgs/1/123.456.jpg'; output='output.txt'; backend; result"

N_RESULTS = 10;

tic;

if ~exist('pqPcaEncodings', 'var')
    load ('/mnt/Data/VLADs/filenamesAll')
    load ('/mnt/Data/VLADs/clusters')
    load ('/mnt/Data/VLADs/clustersAdaptedCenters')
    load ('/mnt/Data/VLADs/pca')
    load ('/mnt/Data/VLADs/pqPcaEncodings')
    %load('/mnt/Data/VLADs/pcaEncodingsAllPlusHolidays.mat')
    load ('/mnt/Data/VLADs/pqClusters')
    load ('/mnt/Data/VLADs/pqDistances')
    load ('/mnt/Data/VLADs/pqRotation')
    toc;
end

queries = strsplit(query, '\n');

n_queries = numel(queries)-1;
ranks = spalloc(n_queries, size(pqPcaEncodings,2), n_queries*N_RESULTS);

parfor i=1:n_queries
    try
        ranks(i,:) = backendNotParallel (queries{i}, ...
        pqPcaEncodings, clusters, adaptedCenters, coeff, pqClusters, pqRotation, N_RESULTS)
    catch err
        fprintf('Couldn''t process img "%s"\n', queries{i});
    end
end

ranks = full(ranks);
[ranks,ix] = sort(max(ranks), 'descend');

fprintf('Processed %d images.\n', n_queries);
toc;

% write result
result = sprintf('/mnt/Images/%s\n', filenames{ix(1:10)});
