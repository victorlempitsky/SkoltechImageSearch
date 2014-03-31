% usage: "query='imgs/1/123.456.jpg'; output='output.txt'; backend; result"

N_RESULTS = 8;

MULTIPLE_QUERIES = 0;

tic;

if ~exist('hm', 'var')
    load('/mnt/Data/arutar/HASH/Imgs.mat');
    load('/mnt/Data/arutar/HASH/vocabulary_255.mat');
    load('/mnt/Data/arutar/HASH/hm_500k.mat');
    load('/mnt/Data/arutar/HASH/data.mat');
    load('/mnt/Data/arutar/HASH/min_hashes_13.mat');
    n = 2; % number of elements per sketch
    k = 512; % number of sketches
    N = 512; % number of min-hashes
    toc;
end

queries = strsplit(query, '\n');
% query = 'http://upload.wikimedia.org/wikipedia/commons/d/d3/Nelumno_nucifera_open_flower_-_botanic_garden_adelaide2.jpg';

n_queries = numel(queries)-1;
%ranks = spalloc(n_queries, size(pqPcaEncodings,2), n_queries*N_RESULTS);

if MULTIPLE_QUERIES
%     ranks = [];
%     parfor i=1:n_queries
%         try
%             ranks(i,:) = backendNotParallel (queries{i}, ...
%             pqPcaEncodings, encodings, clusters, adaptedCenters, ...
%             coeff, pqClusters, pqRotation, pqDistances, N_RESULTS);
%         catch err
%             fprintf('Couldn''t process img "%s"\n', queries{i});
%         end
%     end

    %ranks = full(ranks);
%     [ranks,ix] = sort(max(ranks), 'descend');
else
    try
        ranks = query1M(hm, queries{1}, C_255_u, C_255_d, kdtree_u, kdtree_d, hash_funs, n, k, N, subs, min_hashes);
    catch err
        fprintf('Couldn''t process img "%s"\n', queries{1});
    end
    
    names = cell(N_RESULTS,1);
    for i = 1:min([size(ranks,2) N_RESULTS]);
        imx = find(Imgs(ranks(1,i)).name == '/', 2, 'last');
        imx = imx(1);
        names{i} = ['/mnt/Images' Imgs(ranks(1,i)).name(imx:end)];
    end
end

fprintf('Processed %d images.\n', n_queries);
toc;

% write result
result = [];
for i = 1:length(names);
    result = sprintf('%s%s\n', result, names{i});
end
% result = [names{1} '\n' names{2} '\n' names{3} '\n' names{4} '\n' names{5} '\n' names{6} '\n' names{7} '\n' names{8} '\n'];






