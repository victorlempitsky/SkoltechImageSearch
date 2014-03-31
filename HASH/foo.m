function [ hm ] = foo( i, Imgs, kdtree_u, C_255_u, kdtree_d, C_255_d, hash_funs, subs )
    % load sift
    sift = load(Imgs(i).name, '-mat', 'd');
    sift = double(sift.d);

    % kdtrees for half sifts for 2 vocabularies of 255 words
    idxs_u = vl_kdtreequery(kdtree_u, C_255_u, sift(1:64,:));
    idxs_d = vl_kdtreequery(kdtree_d, C_255_d, sift(65:128,:));
    idxs = (idxs_u - 1) .* 255 + idxs_d;
    idxs = unique(idxs);

    % get min hashes
    [~, idx] = min(hash_funs(idxs,:),[],1);
    min_hash = idxs(idx);

    % save map
    hm = containers.Map('KeyType', 'uint32', 'ValueType', 'any');
    if numel(min_hash) ~= 0
        % save sketches
        idx = min_hash(subs(:,1)) .* min_hash(subs(:,2));
        for j = 1:numel(idx)
            hm(idx(j)) = uint32(i);
        end
    end
end

