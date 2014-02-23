function [ enc ] = getVLADFromImg( img, means )
    [~,descriptors] = vl_sift(single(img));
    enc = getVLAD(descriptors, means);
end

