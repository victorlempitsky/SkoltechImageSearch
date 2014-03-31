function[indexes,distances] = PQSearch(query,codebook)
querySize = size(query,2);
totalCentroids = 256;
sliceDim = 128/m;
m =8;
idx = uint8([]);
    for i = 1: querySize
         % distances = bsxfun(@minus,C,X(:,i)).^2;
           distances = abs(repmat(double(query(:,i)),1,totalCentroids) - codebook);
         for j = 1:m
            [~,I] = min(sum(distances(((j-1)*sliceDim)+1:j*sliceDim,:),1));
            idx(j,i) = I-1;
         end
    end
end