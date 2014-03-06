function [ vlad, sifts ] = getVLADFromImg( img, clusters )

    % check colors
    if size(img,3)~=1 && size(img,3)~=3 || numel(size(img))>3
        fprintf('Wrong image format!\n');
        return; % skip this image. it is gif or smth
    end
    if size(img,3)==3
        img = rgb2gray(img);
    end
    
    % get sifts and normalize in L1
    [~,sifts] = vl_sift(single(img));
    sifts = single(sifts);
    sifts = bsxfun(@times, sifts, 1./sum(abs(sifts)));
    sifts = sqrt(sifts);
    
    % compute hard assignments
    distances = vl_alldist2(clusters, sifts);
    assignments = zeros(size(distances));
    [~,ix] = min(distances);
    assignments(sub2ind(size(assignments), ix, 1:size(assignments,2))) = 1;

    % compute VLAD
    vlad = vl_vlad(double(sifts), double(clusters), assignments);
    vlad = single(vlad);
end

