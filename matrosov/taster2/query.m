function [distances] = query( img, means, encodings )

if size(img,3)~=1 && size(img,3)~=3 || numel(size(img))>3
    fprintf('Wrong image format!\n');
    return; % skip this image. it is gif
end
if size(img,3)==3
    img = rgb2gray(img);
end

%enc = getVLAD(img, means);
enc = getVLAD(img, means);

distances = vl_alldist2(enc, encodings);

end

