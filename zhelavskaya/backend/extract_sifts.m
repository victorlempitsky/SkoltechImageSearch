function sift_features_dense = extract_sifts(face_region_set, sifts_number, varargin)

% Parameters:
%   face_region_set - is a cell array of processed images (grayscale) containing face regions
% (size of each is 160x125 pixels, type - single);
%   sifts_number - will be like 10,000 SIFTs.


binSizes = [6 8 12 17 24];

set_size = length(face_region_set);
frames = cell(set_size, 1);
descrs = cell(set_size, 1);

for i = 1 : set_size,
    
    I = face_region_set{i};
    
    
    % frames is a 2 x NUMKEYPOINTS, descrs is a 128 x NUMKEYPOINTS
    [frames{i}, descrs_j] = vl_phow(I, 'sizes', binSizes, 'step', 1);%, 'magnif', 3);
    
    descrs_j = single(descrs_j);
    descrs_j = bsxfun(@times, descrs_j, 1./sum(abs(descrs_j)));
    descrs_j = sqrt(descrs_j);
    
    descrs{i} = descrs_j;
    
end

sift_features_dense.frames = frames;
sift_features_dense.descrs = descrs;

if nargin == 2
    sift_features_dense = vl_colsubset(sift_features_dense, sifts_number);
end