function [ enc ] = getBoWFromImg( img, means )
    [~,descriptors] = vl_sift(single(img));
    enc = getBoW(descriptors, means);
end

