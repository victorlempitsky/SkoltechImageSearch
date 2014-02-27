load('../data/filenames');

N = numel(filenames);
labels = zeros(N);

for i=1:N
    for j=max(1,i-20):min(i+20,N)
        si = filenames{i};
        sj = filenames{j};
        labels(i,j) = strcmp(si(end-9:end-6), sj(end-9:end-6));
    end
end

save('../data/holidaysLabels', 'labels');