function [y_ij, FV_i, FV_j, flag] = get_params(ij, num_samp, scannedData_pos, scannedData_neg, FV)

flag = -1;
y_ij = -1;
FV_i = -1;
FV_j = -1;

if (ij <= num_samp),
    if scannedData_pos{6}(ij) >= 0 && scannedData_neg{7}(ij) >= 0
        
        y_ij = 1;
        FV_i = FV{scannedData_pos{4}(ij)};
        FV_j = FV{scannedData_pos{5}(ij)};
        flag = 1;
    end
else
    if scannedData_pos{6}(ij- num_samp) >= 0 && scannedData_neg{7}(ij- num_samp) >= 0
        
        y_ij = -1;
        FV_i = FV{scannedData_neg{5}(ij - num_samp)};
        FV_j = FV{scannedData_neg{6}(ij - num_samp)};
        flag = 1;
    end
end


