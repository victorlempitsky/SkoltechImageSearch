% usage: "query='imgs/1/123.456.jpg'; output='output.txt'; backend; result"

queries={
    'http://legendyboxing.ru/uploads/posts/2011-08/1313657138_boxing.jpg'
    'http://www.sunhome.ru/UsersGallery/122008/1572300.jpg'
    'http://www.businessweek.com/business_at_work/bad_bosses/archives/boxing.jpg'
    'http://img.sunhome.ru/UsersGallery/012008/1680504.jpg'
    'http://1.bp.blogspot.com/-6GN_RUi2ugY/Tfkx8ItK2mI/AAAAAAAACuA/fI89r5L0c14/s1600/Boxing.jpg'
    'http://www.guzer.com/pictures/boxing-punch.jpg'
    'http://i53.fastpic.ru/big/2013/0223/46/39f6caccbbb5d36791a76f9276f3fc46.jpg'
    'http://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Boxing080905_photoshop.jpg/220px-Boxing080905_photoshop.jpg'};

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
    clear pqPcaEncodings encodings clusters adaptedCenters
    clear coeff pqClusters pqRotationpqDistances
    toc;
end

% queries = strsplit(query, '\n');

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
