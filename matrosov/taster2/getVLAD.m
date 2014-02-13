function [ enc ] = getVLAD( img, means )

 % point = [x,y,scale,orientation]
 % descriptor = uint8 128x1
[~, descriptors] = vl_sift(single(img));

distances = vl_alldist2(means, descriptors);
assignments = zeros(size(distances));

% weight and normalize distances
for j=1:size(distances,2)
    v = double(distances(:,j));
    v = 1/(v+1); % prevent infinities
    v = v/sum(v); % normalize
    assignments(:,j) = v;
end

enc = vl_vlad(double(descriptors), double(means), assignments);

end

