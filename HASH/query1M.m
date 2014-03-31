function [ress] = query1M( hm, Imgs, num, C_255_u, C_255_d, kdtree_u, kdtree_d, hash_funs, N, subs, min_hashes )

    % load sift
    sift = load(Imgs(num).name, '-mat', 'd');
    sift = double(sift.d);

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
        
%         for i = 1:numel(un)
%             % min_hashes
%             ress(2, i) = sum(sum(min_hash == min_hashes(un(i),:)));
%         end
        ress(2,:) = sum_ ./ N;
        
        [~, ix] = sort(ress(2,:), 2, 'descend');
        ress = ress(:,ix);
    end
    
    % plot the results
    s = min([size(ress,2) 4]);
    
    % plot query image
    subplot(3,2,1);
    imx = find(Imgs(1).name == '/', 2, 'last');
    imx = imx(1);
    img = imread(['/mnt/Images' Imgs(num).name(imx:end)]);
    subimage(img);
    axis off;
    
    % plot results
    for i = 1:s
        subplot(3,2,i+2);
        imx = find(Imgs(ress(1,i)).name == '/', 2, 'last');
        imx = imx(1);
        img = imread(['/mnt/Images' Imgs(ress(1,i)).name(imx:end)]);
        subimage(img);
        axis off;
    end

end

