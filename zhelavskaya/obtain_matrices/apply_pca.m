function [sift_features, Y] = apply_pca(VV, sift_features_dense)

X = sift_features_dense.descrs{1};
fr = sift_features_dense.frames{1}(1 : 2, :);
% l = size(sift_features_dense.descrs{1}, 2);

for i = 2 : length(sift_features_dense.descrs),
    i
    X = [X sift_features_dense.descrs{i}];
    %     l = l + size(sift_features_dense.descrs{i}, 2)
    
    fr = [fr sift_features_dense.frames{i}(1 : 2, :)];
end


[m, n] = size(X);
AMean = mean(X, 2);
B = X - repmat(AMean, 1, n);

Y = VV' * B;

% Spatial augmentation
Y = [Y; fr];

% Calc for each vector
sift_features = cell(length(sift_features_dense.descrs), 1);

l_prev = 0;
for i = 1 : length(sift_features_dense.descrs),
    i
    sift_features{i} = Y(:, l_prev + 1 : l_prev + size(sift_features_dense.descrs{i}, 2));
    l_prev = l_prev + size(sift_features_dense.descrs{i}, 2);
end

