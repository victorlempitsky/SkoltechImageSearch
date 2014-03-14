function [ distances ] = pq_alldist( pq1, pq2, pqDistances )
% pq1 - queries, pq2 - encodings

subDistances = zeros(size(pq1,2), size(pq2,2), 16);

pq1 = pq1+1;
pq2 = pq2+1;

for i=1:16
    subDistances(:,:,i) = pqDistances(pq1(i,:), pq2(i,:), i);
end

distances = sum(subDistances, 3);

end

