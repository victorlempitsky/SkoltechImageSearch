function [ distances ] = getPqDistances( pq1, pq2, pqDistances )
% pq1 - query, pq2 - encodings

distances = zeros(16, size(pq2,2));

pq1 = pq1+1;
pq2 = pq2+1;

for i=1:16
    distances(i,:) = pqDistances(pq1(i), pq2(i,:));
end

distances = sum(distances);

end

