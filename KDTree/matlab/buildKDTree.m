function [ tree ] = buildKDTreeV4(aSet, indSet)
% creates a kd-tree for the input set aSet
% aSet: the set of points to construct the kd-tree
% aSet row - a point of the set
%
%

%    aSet = unique(aSet, 'rows');
    [setRows, setDims] = size(aSet);
    numAxes = 10;
    
    if setRows < 2 
        error('A set must contain at least two points');
    end
    
    splitingMaskVectors = getSplitingBinCombinations( aSet, numAxes );
    combinationsAmount = size(splitingMaskVectors, 1);
    combinationCounter = 1;
    
    nodesMaxAmount = power(2, ceil(log2(setRows)));
    
    levels = ceil(log2(setRows))+1;
    
    idGenerator = single(1);
    level = single(1);
    
    left = single(0);
    right = single(1);
    
    
    % indSet = 1:setRows;
    
    %% creating the sorage for the tree's nodes
    % column1 - node struct instance
    % column2 - set for the node
    % column3 - set of indices for the node
    nodeData = cell(nodesMaxAmount, 3);
    
    % column1 - node id
    % column2 - parent node // -1 for the root node
    % column3 - parent branch: left or right 0/1   // -1 for the root node
    % column4 - level
    nodeInfo = zeros(nodesMaxAmount, 4, 'single');
    
    %% adding the root node
    rootNode = createNode(0, 0, 0, 0);
    
    nodeData{1, 1} = rootNode;
    nodeData{1, 2} = aSet;
    nodeData{1, 3} = indSet;
    
    nodeInfo(1, :) = [idGenerator -1 -1 level];
    idGenerator = idGenerator + 1;
    
    rowPointer = 2;
    
    %% processing the node sotrage
    while (true)
        nodeInfoToProcessIdxs = nodeInfo(:, 4) == level;
        nodesToProcessNumber = sum(nodeInfoToProcessIdxs);
        
        % if there isn't any node to process than stop the loop 
        if  nodesToProcessNumber == 0
            break;  % <------------------  loop interrupting
        end 

        disp(['level ' num2str(level) ' out of ' num2str(levels)]);
        level = level + 1;
        
        nodeInfoToProcess = nodeInfo(nodeInfoToProcessIdxs, :);
        nodeDataToProcess = nodeData(nodeInfoToProcessIdxs, :);
        nodeIndices = find(nodeInfoToProcessIdxs == 1);
        
        %% processing the nodes of the current level
        for i = 1:nodesToProcessNumber
            
            curNodeInfo = nodeInfoToProcess(i, :);
            curNodeData = nodeDataToProcess(i, :);
             
            curSet = curNodeData{2};
            curIndSet = curNodeData{3};
            parentId = curNodeInfo(1);
            
            isBadPartition = 1;
            currComb = 0;
            while (isBadPartition)
                dimNumber = splitingMaskVectors(mod(combinationCounter, combinationsAmount) + 1, :);
                combinationCounter = combinationCounter + 1;
                currComb = currComb + 1;
                projectionSet = curSet*dimNumber';
                dimValue = median(projectionSet);
                setRows = size(projectionSet, 1);                    

                leftSetIdxes = projectionSet <= dimValue;
                
                %changing data a little bit
                if currComb > combinationsAmount
                    projectionSet(1) = projectionSet(1) + projectionSet(1)/1e06;
                end

                leftSetIdxes = projectionSet <= dimValue;
                isBadPartition = 0;
                % in case of the median value is equal 
                % to maximum element in the choosen dimension of the set
                if sum(leftSetIdxes) == setRows
                     unCurSet = unique(projectionSet);
                     if numel(unCurSet)== 1
                        %bad separator detected, pick another one
                        isBadPartition = 1;
                    else
                        diff = abs(unCurSet(end)) - abs(unCurSet(end-1));
                        
                        dimValue = dimValue - abs(diff/100);
                        leftSetIdxes = projectionSet <= dimValue;
                    end
                end
            end
            leftSet = curSet(leftSetIdxes, :);
            leftIndSet = curIndSet(leftSetIdxes);
            rightSet = curSet(~leftSetIdxes, :);
            rightIndSet = curIndSet(~leftSetIdxes);
            
            % update info for parent node
            nodeData{nodeIndices(i), 1}.dimValue = dimValue;
            nodeData{nodeIndices(i), 1}.dimNumber = dimNumber;
            
            %% check right and left set
            % left
            if size(leftSet, 1) > 1
                % create new row for nodeInfo array
                newNodeInfo = [idGenerator parentId left level];
                idGenerator = idGenerator + 1;
                
                % add data to storage
                nodeData{rowPointer, 1} = createNode(0, 0, 0, 0);
                nodeData{rowPointer, 2} = leftSet;
                nodeData{rowPointer, 3} = leftIndSet;
                nodeInfo(rowPointer, :) = newNodeInfo;
                rowPointer = rowPointer + 1;
                
                % link parent node with just created one
                %nodeData{nodeIndices(i), 1}.left = nodeData{end, 1};
            else
                nodeData{nodeIndices(i), 1}.left = createLeaf(leftSet, leftIndSet);
            end    
           
            % right
            if size(rightSet, 1) > 1
                % create new row for nodeInfo array
                newNodeInfo = [idGenerator parentId right level];
                idGenerator = idGenerator + 1;
                
                % add data to storage
                nodeData{rowPointer, 1} = createNode(0, 0, 0, 0);
                nodeData{rowPointer, 2} = rightSet;
                nodeData{rowPointer, 3} = rightIndSet;
                nodeInfo(rowPointer, :) = newNodeInfo;
                rowPointer = rowPointer + 1;
                
                % link parent node with just created one
                %nodeData{nodeIndices(i), 1}.right = nodeData{end, 1};
            else
                nodeData{nodeIndices(i), 1}.right = createLeaf(rightSet, rightIndSet);
            end
            
%             clear leftSet;
%             clear rightSet;
        end
    end
    
    %% backtracking linking all nodes
    disp('backtracking');
    level = level - 1;
    
    % connect each node to its parent node 
    while (level > 1)
        nodeInfoToProcessIdxs = nodeInfo(:, 4) == level;
        level = level - 1;
        
        nodeInfoToProcess = nodeInfo(nodeInfoToProcessIdxs, :);
        nodeDataToProcess = nodeData(nodeInfoToProcessIdxs, :);
        nodesToProcessNumber = sum(nodeInfoToProcessIdxs);
        
        % skip an empty level
        if nodesToProcessNumber == 0
           continue; % <------------------  loop restarting
        end
        
        for i = 1:nodesToProcessNumber
            curNodeInfo = nodeInfoToProcess(i, :);
            curNodeData = nodeDataToProcess(i, :);
 
            parentNodeId = curNodeInfo(2);
            parentNodeBranch = curNodeInfo(3);
            curNode = curNodeData{1};
            
            % find parent node 
            parentNodeIdx = find(nodeInfo(:, 1) == parentNodeId);
            
            % connect current node to its parent node depending on branch
            if parentNodeBranch == left
                nodeData{parentNodeIdx, 1}.left = curNode;
            else % right
                nodeData{parentNodeIdx, 1}.right = curNode;
            end
        end 
    end
    
    %% pick the root node
    tree = nodeData{1, 1};
end

