%% Calculate precision on Holidays database

Imgs2 = dir('/mnt/Images/Holidays/');
Imgs2 = Imgs2(3:end-1);

group_count = 0;
prob = 0;

for i = 2:numel(Imgs2)+1
    if i == numel(Imgs2)+1 || str2double(Imgs2(i).name(end-5:end-4)) == 0
        imagesNum = str2double(Imgs2(i - 1).name(end - 5:end - 4)) + 1;
        idx_first =  i - imagesNum;
        
        % probability
        ress = queryHolidays( hm, sifts, idx_first, C_255_u, C_255_d, kdtree_u, kdtree_d, hash_funs, n, k, N, subs, min_hashes );
        try
            correct = sum((idx_first : i - 1) == sort(ress(1,1:imagesNum)));
        catch exc
            temp = zeros(size(idx_first : i - 1));
            res = sort(ress(1,1:end));
            for j = 1:numel(res)
                temp(j) = res(j);
            end
            correct = sum((idx_first : i - 1) == temp);
        end
        prob_ = correct / imagesNum;
        prob = prob + prob_;
        
        group_count = group_count + 1;
    end
end

prob = prob / group_count








