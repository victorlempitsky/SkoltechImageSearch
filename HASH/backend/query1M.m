function [ress] = query1M( hm, query, C_255_u, C_255_d, kdtree_u, kdtree_d, hash_funs, N, subs, min_hashes )

    % resize image if needed (Mikhail Matrosov(c))
    MAX_IMG_SIZE = 1024;
    
    img = imread(query);
    sz = size(img);
    sz = sz([1,2]);
    if sz(1)>MAX_IMG_SIZE || sz(1)>MAX_IMG_SIZE
        img = imresize(img, 1024.0/max(sz));
    end
    img = rgb2gray(img);
    [~,sift] = vl_sift(single(img));
    sift = double(sift);

    % kdtrees for half sifts for 2 vocabularies of 255 words
    idxs_u = vl_kdtreequery(kdtree_u, C_255_u, sift(1:64,:));
    idxs_d = vl_kdtreequery(kdtree_d, C_255_d, sift(65:128,:));
    idxs = (idxs_u - 1) .* 255 + idxs_d;
    idxs = unique(idxs);

    % get min hashes
    [~, idx] = min(hash_funs(idxs,:));
    min_hash = idxs(idx);

    % get results
    res = [];
    idx = min_hash(subs(:,1)) .* min_hash(subs(:,2));

    for j = 1:size(idx,2)
        if hm.isKey(idx(j))
            res = [res hm(idx(j))];
        end
    end

    ress = 0;
    un = unique(res);
    if ~isempty(un)
        ress = zeros(2,numel(un));
        ress(1,:) = un;
        
        sum_ = repmat(min_hash, size(un,2), 1) == min_hashes(un,:);
        sum_ = sum(sum_, 2);
        sum_ = sum_';
        
        ress(2,:) = sum_ ./ N;
        
        [~, ix] = sort(ress(2,:), 2, 'descend');
        ress = ress(:,ix);
    end
    
%     % plot the results
%     s = min([size(ress,2) 4]);
%     
%     % plot query image
%     subplot(3,2,1);
%     img = imread(query);
%     subimage(img);
%     axis off;
%     
%     % plot results
%     for i = 1:s
%         subplot(3,2,i+2);
%         imx = find(Imgs(ress(1,i)).name == '/', 2, 'last');
%         imx = imx(1);
%         img = imread(['/mnt/Images' Imgs(ress(1,i)).name(imx:end)]);
%         subimage(img);
%         axis off;
%     end

end

