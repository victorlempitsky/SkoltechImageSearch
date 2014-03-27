function [ bestNode, bestDistance, resultStack, leafsVisited ]...
    = searchKDTree(node, point, maxLeafsToVisit)
%performs the search for the given point in the the given tree 
%the priority queue version of the kd-tree seaching algorithm
    %% output params initialization
    bestDistance = +inf;
    leafsVisited = 0;
    
    %% fake initial best node
    pointLen = size(point, 2);
    infPoint = zeros(1, pointLen);
    infPoint(:) = +inf;
    
    bestNode = createLeaf(infPoint, 0);

    %% result stack initialization
    % column 1 - point
    % column 2 - distance
    % column 3 - distance
    resultStack = cell(maxLeafsToVisit, 3);
    stackIndex = 1;
    bestPointCounter = 1;

    
    %% queue initialization  
    % queue is a priority queue. the priority term is a distance.
    % then smaller the distance then higher the priority
    % column 1: node
    % column 2: distance value
    queue = cell(0, 2);
    
    queue{end+1, 1} = node;
    queue{end, 2} = 0;
    
    %% queue processing
    % take out a node from the queue with smallest distance 
    while (size(queue, 1) > 0 && maxLeafsToVisit > leafsVisited)
        
        queueDist = cell2mat(queue(:, 2));
        candidateNodeIdxes = find(queueDist == min(queueDist));  
        currentNodeIdx = candidateNodeIdxes(end);
        currentNode = queue{currentNodeIdx, 1};
        queue(currentNodeIdx, :) = [];
        
        %% node checking
        if currentNode.isLeaf
            % check if currentNode is closer to query point 
            % if so, save it as a best found so far
            [ bestNode, bestDistance, isNewBestFound ] = checkNodeForBest(point, currentNode, bestNode, bestDistance);
            leafsVisited = leafsVisited + 1;
            
            if (isNewBestFound)
                resultStack{stackIndex, 1} = bestNode.point;
                resultStack{stackIndex, 2} = bestNode.ID;
                resultStack{stackIndex, 3} = bestDistance;
                stackIndex = stackIndex + 1;
                bestPointCounter = bestPointCounter + 1;
            end    
        else
            % if it's not a leaf than choose the branch where to go further
            % in the tree
            pointProjection = currentNode.dimNumber * point';
            
            if (pointProjection <= currentNode.dimValue)
               chosenBranch = currentNode.left;
               notChosenBranch = currentNode.right;
            else
               chosenBranch = currentNode.right;
               notChosenBranch = currentNode.left;               
            end
            
            % add chosen branch (node) to the tree with 0 distance
            queue{end+1, 1} = chosenBranch;
            queue{end, 2} = 0;
            
            % process the not chosen branch (node)
            if (notChosenBranch.isLeaf)
                % check if currentNode is closer to query point 
                % if so, save it as a best found so far
                [ bestNode, bestDistance, isNewBestFound ] = checkNodeForBest(point, notChosenBranch, bestNode, bestDistance);    
                leafsVisited = leafsVisited + 1;
                if (isNewBestFound)
                    resultStack{stackIndex, 1} = bestNode.point;
                    resultStack{stackIndex, 2} = bestNode.ID;
                    resultStack{stackIndex, 3} = bestDistance;
                    stackIndex = stackIndex + 1;
                    bestPointCounter = bestPointCounter + 1;
                end  
            else
                % if not, add it to query only when the distance to the
                % node is less or equal than the best distance to the node
                % found so far
                dist = getDistance(pointProjection, currentNode.dimValue);

                if dist <= bestDistance
                    queue{end+1, 1} = notChosenBranch;
                    queue{end, 2} = double(dist);
                end
            end
        end
    end 
    
    resultStack = resultStack(1:(bestPointCounter-1), :);
    resultStack = flipud(resultStack);
end

