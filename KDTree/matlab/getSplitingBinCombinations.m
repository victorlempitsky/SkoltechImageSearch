function [ splitingMaskVectors ] = getSplitingBinCombinations( aSet, numAxes )
    
    [pointsNumber, dimNumber] = size(aSet);
    variances = var(aSet);

    [m, topAxesIdxes] = sort(variances, 'descend');
    topAxes = topAxesIdxes(1:numAxes);

    shrunkSet = aSet(:, topAxes); 
    means = mean(shrunkSet);

    covarMtrx = zeros(numAxes, numAxes);

    % set's items normalization
    for axe = 1:numAxes
        for pNum = 1:pointsNumber
            b = shrunkSet(pNum, axe) - means(axe); 
            shrunkSet(pNum, axe) = shrunkSet(pNum, axe) - means(axe);
        end
    end


    %covariance matrix calculation
    for i = 1:numAxes
        for j = 1:numAxes
            covarMtrx(i, j) = shrunkSet(:, i)' * shrunkSet(:, j);
        end
    end

    nnElementsAmount = zeros(1, numAxes);

    for i = 1:dimNumber
        nnElementsAmount(i) = nnz(aSet(:, i)); 
    end

    %last column is the varince value of the binary combination
    rowsInMaskMtrx = (numAxes^2 - numAxes)/2;
    maskMtrx = zeros(rowsInMaskMtrx, dimNumber+1);

    index = 1;
    for i = 1:numAxes
        for j = i:numAxes
            maskMtrx(index, topAxes(i)) = 1; 
            maskMtrx(index, topAxes(j)) = 1; 
            maskMtrx(index, end)= covarMtrx(i, j);
            index = index + 1;
        end
    end

%     cmbs = [0  1; 
%             0 -1;
%             1  0;
%             1  1;
%             1 -1;
%            -1  0;
%            -1  1;
%            -1 -1];

    cmbs = [1  1; 
            1 -1;];


    cmbsRows = size(cmbs, 1); 

    % 3*3 - 1 - all binary combinations 
    %           made of mask vector and {-1, 0, 1} vector except [0 0]
    rowsInExtMtrx = rowsInMaskMtrx*cmbsRows;
    extendedMaskMatrix = zeros(rowsInExtMtrx, dimNumber+1);

    for i = 1:rowsInMaskMtrx
        currentRow = maskMtrx(i, :);
        idxs = find(currentRow(1:dimNumber) == 1);
        idxsLen = numel(idxs);

        for j = 1:cmbsRows
            newRow = currentRow;
            nzValFactor = 0;
            for k = 1:idxsLen
                newRow(idxs(k)) = cmbs(j, k);  
                nzValFactor = nzValFactor + nnElementsAmount(idxs(k));
            end
            newRow(dimNumber+1) = ...
                1/nzValFactor * newRow(1:dimNumber) * ...
                newRow(dimNumber+1) * newRow(1:dimNumber)';

            extendedMaskMatrix((i-1)*cmbsRows+j, :) =  newRow;
        end
    end

    [~, sortOrder] = sort(abs(extendedMaskMatrix(:, end)), 'descend');
    
    extendedMaskMatrix = extendedMaskMatrix(sortOrder, :);
    
%     % multiplication to var
%     mults = extendedMaskMatrix(:, end);
%     for i = 1:rowsInExtMtrx
%         extendedMaskMatrix(i, :) = extendedMaskMatrix(i, :) * mults(i);  
%     end
    
    % check for orthogonality
    for i = 1:rowsInExtMtrx
        rowToExam = extendedMaskMatrix(i, 1:end-1);

        if (extendedMaskMatrix(i, end) == 0)
            continue;
        end        
        for j = i+1:rowsInExtMtrx
            if (extendedMaskMatrix(j, end) == 0)
                continue;
            else
                c = extendedMaskMatrix(j, 1:end-1);
                v = rowToExam * c';
                if rowToExam * extendedMaskMatrix(j, 1:end-1)' ~= 0 ...
                        | rowToExam * extendedMaskMatrix(j, 1:end-1)' == sum(rowToExam .* rowToExam)
                	extendedMaskMatrix(j, end) = 0;   
                end
            end
        end    
    end
    
    zeroElementsIdxes = extendedMaskMatrix(:, end) ~= 0;
    extendedMaskMatrix = extendedMaskMatrix(zeroElementsIdxes, :);
    
    splitingMaskVectors = extendedMaskMatrix(:, 1:end-1);
    
    zeroElementsIdxes = sum(splitingMaskVectors') ~= 0;
    splitingMaskVectors = splitingMaskVectors(zeroElementsIdxes, :);
    
end

