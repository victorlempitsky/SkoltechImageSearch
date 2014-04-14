file_people='/data_lfw/peopleDevTrain.txt';
file_pairs='/data_lfw/pairsDevTrain.txt';

[scannedData_pos, scannedData_neg, scannedData_people, num_samp, num_people] = read_files(file_pairs, file_people);


scannedData_pos{6} = zeros(1, 1100);
scannedData_neg{7} = zeros(1, 1100);

for i = 1 : 1100    % pairs
%     i
    % 8676 of images peopleToFV
    
    name_ind_pos = find(strcmp(peopleToFV(:, 1), scannedData_pos{1}{i}));
    img1_ind_pos = find(peopleToFV2{2}== scannedData_pos{2}(i));
    img2_ind_pos = find(peopleToFV2{2}== scannedData_pos{3}(i));
    
    fv1 = intersect(name_ind_pos, img1_ind_pos);
    fv2 = intersect(name_ind_pos, img2_ind_pos);
    
    if ~isempty(fv1) && ~isempty(fv2)
        
        scannedData_pos{4}(i) = intersect(name_ind_pos, img1_ind_pos);
        scannedData_pos{5}(i) = intersect(name_ind_pos, img2_ind_pos);
    else
        scannedData_pos{6}(i) = -1;
    end
    
    
    
    name1_ind_neg = find(strcmp(peopleToFV(:, 1), scannedData_neg{1}{i}));
    name2_ind_neg = find(strcmp(peopleToFV(:, 1), scannedData_neg{3}{i}));
    img1_ind_neg = find(peopleToFV2{2}== scannedData_neg{2}(i));
    img2_ind_neg = find(peopleToFV2{2}== scannedData_neg{4}(i));
    
    fv1 = intersect(name1_ind_neg, img1_ind_neg);
    fv2 = intersect(name2_ind_neg, img2_ind_neg);
    
    if ~isempty(fv1) && ~isempty(fv2)
        
        scannedData_neg{5}(i) = intersect(name1_ind_neg, img1_ind_neg);
        scannedData_neg{6}(i) = intersect(name2_ind_neg, img2_ind_neg);
    else
        scannedData_neg{7}(i) = -1;
    end
    
    
  
end

