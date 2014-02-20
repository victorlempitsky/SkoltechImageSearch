N_IMAGES = 1200;
N_SIFTS_PER_IMG = 200;
CODEBOOK_SIZE = 4096;
N_ATTEMPTS_TO_CLASTERIZE = 10;

if ~exist('sifts')
    load('../data/sifts');
end

clusterizations = {};
clusterCentersIDs = [];

for attempt=1:N_ATTEMPTS_TO_CLASTERIZE
    % get descriptors
    descriptorsSet = [];
    descriptorsIDs = []; % id = 100000*img# + sift#
    for img = randsample(1:numel(sifts), N_IMAGES)
        descriptors = sifts{img};
        subset = randsample(1:size(descriptors,2), N_SIFTS_PER_IMG);
        descriptorsSet = [descriptorsSet, descriptors(:,subset)];
        descriptorsIDs = [descriptorsIDs, img*100000+subset];
    end

    % clasterize descriptors
    means = vl_ikmeans(descriptorsSet, CODEBOOK_SIZE); % codebook=dictionary
    means = uint8(means);
    clusterizations{attempt} = means;
    
    % now find ids for claster centers
    [~, ixs] = min(vl_alldist2(descriptorsSet, means));
    clusterCentersIDs(:,attempt) = descriptorsIDs(ixs)';
    
    % print progress
    if(mod(attempt,10)==0)
        fprintf('%i\n', attempt);
    else
        fprintf('.');
    end
end

save('../data/clusterizations4096', 'clusterizations');
%save('clusterCentersIDs', 'clusterCentersIDs');

