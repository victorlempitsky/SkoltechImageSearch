function [ mAP ] = getMAP( labels, encodings )

mAPs = [];
for j=1:size(encodings,2)
    distances = vl_alldist2(encodings(:,j), encodings);
    [recall, precision] = vl_pr(labels(j,:), -distances(:));
    mAPs(j) = trapz(recall, precision);
end

mAP = mean(mAPs);

end

