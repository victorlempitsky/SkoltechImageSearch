N_IMAGES = 1000;
N_SIFTS_PER_IMG = 10;
CODEBOOK_SIZE = 64;

list = imgsList(); % get file names from training set
list = randsample(list, N_IMAGES); % choose some random images

descriptorsSet = [];

% get descriptors
for i=1:numel(list)
    fname = list{i}; % read img
    try
        img = imread(fname);
    catch err
        continue;
    end
    
    if size(img,3)~=1 && size(img,3)~=3 || numel(size(img))>3
        continue; % skip this image. it is gif
    end
    if size(img,3)==3
        img = rgb2gray(img);
    end
    
     % point = [x,y,scale,orientation]
     % descriptor = uint8 128x1
    [~, descriptors] = vl_sift(single(img));
    
    descriptorsSet = [descriptorsSet,...
        vl_colsubset(descriptors, N_SIFTS_PER_IMG)];
    
    % print progress
    if(mod(i,10)==0)
        if(mod(i,100)==0)
            fprintf('%i\n', i);
        else
            fprintf('.');
        end
    end
end

% clasterize descriptors
fprintf('Clasterizing descriptors\n');
means = vl_ikmeans(descriptorsSet, CODEBOOK_SIZE); % codebook=dictionary
means = uint8(means);
save('means', 'means');

