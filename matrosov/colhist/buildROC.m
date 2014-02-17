load('colhists');
hlist = holidaysList();
N = numel(hlist);

% get groups / labels
labels = zeros(N);
for i=1:N
    for j=max(1,i-20):min(i+20,N)
        si = hlist{i};
        sj = hlist{j};
        labels(i,j) = strcmp(si(end-9:end-6), sj(end-9:end-6));
    end
end


distances = vl_alldist2(colhists, colhists);

[recall, precision] = vl_pr(labels(:)-0.5, -distances(:));
plot(recall, precision);
xlabel('Recall');
ylabel('Precision');