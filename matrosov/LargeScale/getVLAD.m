function [ enc ] = getVLAD( descriptors, means )

 % point = [x,y,scale,orientation]
 % descriptor = uint8 128x1

distances = vl_alldist2(means, descriptors);
assignments = zeros(size(distances));

% weight and normalize distances
%for j=1:size(distances,2)
    %v = double(distances(:,j));
    %v = 1/(v+1); % prevent infinities
    %v = v/sum(v); % normalize
    %assignments(:,j) = v;
%end

[~,ix] = max(distances);
assignments(sub2ind(size(assignments), ix, 1:size(assignments,2))) = 1;

enc = vl_vlad(double(descriptors), double(means), assignments);
% NormalizeComponents, SquareRoot

%enc = int8(enc*1270);
enc = single(enc);

end

