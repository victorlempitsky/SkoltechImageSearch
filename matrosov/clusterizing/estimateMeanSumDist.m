meanDist = 0;
maxDist = 0;

k = 10;

load('clusterizationDistances');
D = clusterizationDistances;

for i=1:1000000
    d = sumDistances(D, randsample(1:100, k));
    meanDist = (meanDist*(i-1)+d)/i;
    maxDist = max(maxDist, d);
    if mod(i, 30000)==0
        fprintf('%d, Mean=%.3e, Max=%.3e\n', i, meanDist, maxDist);
    end
end