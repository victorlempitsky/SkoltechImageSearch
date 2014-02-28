function [ enc ] = getVLADFromImg( img, means )
    [~,d] = vl_sift(single(img));
    
    d = single(d);
    d = bsxfun(@times, d, 1./sum(abs(d)));
    d = sqrt(d);

    enc = getVLAD(d, means);
end

