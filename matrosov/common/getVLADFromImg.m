function [ enc ] = getVLADFromImg( img, means )
    [~,d] = vl_sift(single(img));
    d = uint8(sqrt(single(d))*16);
    enc = getVLAD(d, means);
end

