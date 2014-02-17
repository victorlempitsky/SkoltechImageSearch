function [ h ] = colhist( img, nbins )
% Calculates color histogram with nbins along each dimension.
% Returns vector nbins^3 x 1. img is int from 0 to 255

assert(numel(size(img))<=3 && (size(img,3)==3 || size(img,3)==1),...
    'colhist(img): numel(size(img))<=3 && size(img,3)==3');

if size(img,3)==1 % grayscale to rgb
    img = repmat(img, 1, 1, 3);
end

reducedColors = floor(double(img)*nbins/256);
indexed = (reducedColors(:,:,1)*nbins + ...
           reducedColors(:,:,2))*nbins + ...
           reducedColors(:,:,3);

h = histc(indexed(:), 0:nbins^3-1);
h = h/sum(h);

end

