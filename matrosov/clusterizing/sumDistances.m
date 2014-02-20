function [ dist ] = sumDistances( D, subset )

D = D + eye(100)*1e100;
dist = min(min(D(subset, subset)));

end

