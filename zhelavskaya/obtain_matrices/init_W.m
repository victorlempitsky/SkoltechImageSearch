function W_init = init_W(FV)
% Initialization of W by PCA whitening


% 1. Make one matrix out of our separate FVs

X = FV{1};

for i = 2 : length(FV),
    X = [X FV{i}];
end

X = X';


% 2. Compute PCQ whitening

epsilon = 0.1;

avg = mean(X, 1);     % Compute the mean pixel intensity value separately for each patch
B = X - repmat(avg, size(X, 1), 1);

sigma = B * B' / size(B, 2);

[U,S,V] = svd(sigma);

% 

% [m, n] = size(X);
% AMean = mean(X, 2);
% B3 = X - repmat(AMean, 1, n);
% Z = 1 / sqrt(n - 1) * B3';
% covZ = Z' * Z;
% 
% % Singular value decomposition
% [U3, S3, V3] = svd(covZ);
% % variances = diag(S) .* diag(S);
% % bar(variances(1:30))
% 
% % Extract first 64 principal components
% PCs = 64;
% VV = V3(:, 1 : PCs);
% 
% Y = VV' * B3;

% 

xPCAwhite = diag(1./sqrt(diag(S) + epsilon)) * U' * B;
PCs = 128;
W_init = xPCAwhite(1 : PCs, :);