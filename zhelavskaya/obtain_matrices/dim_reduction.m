function W = dim_reduction(num_samp, W_init, FVs, gamma, num_iters, scannedData_pos, scannedData_neg)
% Low-rank Mahalanobis metric learning

W_prev = W_init; % 128 x 67000
b = 2;

for iter = 1 : num_iters,
    
    ij = randi(2 * num_samp, 1);
    [y_ij, FV_i, FV_j, flag] = get_params(ij, num_samp, scannedData_pos, scannedData_neg, FVs);
    
    if flag == 1
        diff_ij = FV_i - FV_j;
        d_ij = (W_prev * diff_ij)' * (W_prev * diff_ij);


        if (y_ij * (b - d_ij) > 1)
            W = W_prev;
        else
            psi_ij = diff_ij' * diff_ij;
            W = W_prev - gamma * y_ij * W_prev * psi_ij;
        end


        W_prev = W;

        if (mod(iter , 10) == 0)
            gamma = gamma / 2;
        end
    end
end


