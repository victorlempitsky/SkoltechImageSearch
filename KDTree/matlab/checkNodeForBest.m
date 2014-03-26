function [ bestNode, bestDistance, isNewBestFound ] = checkNodeForBest(point, candidateNode, curBestNode, curBestDistance)
% checks if the candidate point is closer to query point than that one
% which is currently considered as the best one
    dist = getDistance(candidateNode.point, point);
    isNewBestFound = 0;

    % check whether current point is better (closer) 
    % the then one found so far
    if dist < curBestDistance
        % if so, store it as the best and update the best distance
        bestDistance = dist;
        bestNode = candidateNode;
        isNewBestFound = 1;
    else
        bestDistance = curBestDistance; 
        bestNode = curBestNode;
    end
end

