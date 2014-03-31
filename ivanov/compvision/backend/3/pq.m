function [ pqpca ] = pq( pqClusters, encodings )
% computes product quantization for an arbitrary ammount of encodings

pqpca = [];
for i=1:16
    ix = (i-1)*16 + (1:16);
    distances = vl_alldist2( pqClusters(:,:,i), encodings(ix,:) );
    [~,ix] = min(distances);
    pqpca(end+1,:) = ix;
end

pqpca = uint8(pqpca-1);

end

