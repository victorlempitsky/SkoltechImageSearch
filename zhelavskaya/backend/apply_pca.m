function sifts_pca = apply_pca(VV, sifts)

X = sifts.descrs{1};
fr = sifts.frames{1}(1 : 2, :);
% % l = size(sift_features_dense.descrs{1}, 2);
% 
% for i = 2 : length(sift_features_dense.descrs),
%     i
%     X = [X sift_features_dense.descrs{i}];
%     %     l = l + size(sift_features_dense.descrs{i}, 2)
%     
%     fr = [fr sift_features_dense.frames{i}(1 : 2, :)];
% end


[m, n] = size(X);
AMean = mean(X, 2);
B = X - repmat(AMean, 1, n);

Y = VV' * B;

% Spatial augmentation
sifts_pca = [Y; fr];
