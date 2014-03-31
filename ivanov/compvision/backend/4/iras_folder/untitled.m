FVs = [FVs1; FVs2];

upd_FVs_dataset = cell(length(FVs), 1);

for i = 1 : length(FVs),
    i
    upd_FVs_dataset{i} = W * FVs{i};
end

save('/mnt/sifts_matrices/upd_FVs_set.mat', 'upd_FVs_set');