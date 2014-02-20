function [distances] = query( img, colhists )

if size(img,3)~=1 && size(img,3)~=3 || numel(size(img))>3
    fprintf('Wrong image format!\n');
    return; % skip this image. it is gif
end

%enc = getVLAD(img, means);
enc = colhist(img, 4);

distances = vl_alldist2(enc, colhists);

end

