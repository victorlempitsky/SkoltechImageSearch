load('clusterizations');

N = numel(clusterizations);

D = zeros(N);

for i=1:N
    for j=1:N
        D(i,j) = clusterizationsDist(clusterizations{i}, clusterizations{j});
    end
    disp(i);
end