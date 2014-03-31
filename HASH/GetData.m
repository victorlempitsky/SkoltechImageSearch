%% Get hash_funs, kd-trees, subs
n = 2; % number of elements per sketch
k = 512; % number of sketches
N = 512; % number of min-hashes
vocabulary_size = 255^2;

hash_funs = single(rand(vocabulary_size, N));
min_hashes = uint16(zeros(numel(Imgs), N));

kdtree_u = vl_kdtreebuild(C_255_u);
kdtree_d = vl_kdtreebuild(C_255_d);

subs = zeros(k,n);
if N / k == n
    for i = 1:k
        subs(i,:) = (i - 1) * n + 1 : i * n;
    end
elseif N / k == 1
    for i = 1:k / 2
        subs(i,:) = (i - 1) * n + 1 : i * n;
        subs(k / 2 + i,:) = (i - 1) * n + 2 : i * n + 1;
    end
    subs(k, :) = [N 1];
end

save('data.mat', 'hash_funs', 'kdtree_u', 'kdtree_d', 'subs')