function [ enc ] = getBoW( descriptors, means )
% Byteho stands for byte-sift holistic descriptor

distances = vl_alldist2(means, descriptors);
[~, m] = min(distances);
enc = hist(m, 1:size(means,2))';
%enc = enc/norm(enc);

end

