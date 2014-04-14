function [VV, fr, B] = conduct_pca(sift_features_dense)

X = sift_features_dense.descrs{1};
fr = sift_features_dense.frames{1}(1 : 2, :);
% l = size(sift_features_dense.descrs{1}, 2);

for i = 2 : 8659%length(sift_features_dense.descrs),
    i
    X = [X sift_features_dense.descrs{i}];
%     l = l + size(sift_features_dense.descrs{i}, 2)

    fr = [fr sift_features_dense.frames{i}(1 : 2, :)];
end

[m, n] = size(X);
AMean = mean(X, 2);
B = X - repmat(AMean, 1, n);
Z = 1 / sqrt(n - 1) * B';
covZ = Z' * Z;

% Singular value decomposition
[U, S, V] = svd(covZ);
% variances = diag(S) .* diag(S);
% bar(variances(1:30))

% Extract first 64 principal components
PCs = 64;
VV = V(:, 1 : PCs);

