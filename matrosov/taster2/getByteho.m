function [ enc ] = getByteho( img, means )
% Byteho stands for byte-sift holistic descriptor

[~, descriptors] = vl_sift(single(img));
distances = vl_alldist2(means, descriptors);
[~, m] = min(distances);
enc = hist(m, 1:64)';

end

