% Count different metrics
num_iters = 100000;%00000;
load('/mnt/sifts_matrices/Winit.mat')

load('/mnt/sifts_matrices/FVs2_1.mat')
load('/mnt/sifts_matrices/FVs2_2.mat')
FVs = [FVs1; FVs2];

[~, ~, ~, num_samp, ~] = read_files(file_pairs, file_people);
load('/mnt/sifts_matrices/other_matrices_from_home/scannedData.mat')
num_samp = num_samp{1};


W(:, :, 1) = dim_reduction(num_samp, W_init, FVs, 1/100, num_iters, scannedData_pos, scannedData_neg);
W(:, :, 2) = dim_reduction(num_samp, W_init, FVs, 1/10, num_iters, scannedData_pos, scannedData_neg);
W(:, :, 3) = dim_reduction(num_samp, W_init, FVs, 1/5, num_iters, scannedData_pos, scannedData_neg);
W(:, :, 4) = dim_reduction(num_samp, W_init, FVs, 1/200, num_iters, scannedData_pos, scannedData_neg);
% W{2} = dim_reduction(file_pairs, file_people, 1/100, num_iters);

save('/mnt/sifts_matrices/metrics.mat', 'W')