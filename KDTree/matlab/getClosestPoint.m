function [ resultDistance, resultPoint ] = getClosestPoint(pointsBase, queryPoint)
%TEST FUNCTION to verify results of the kd-tree search

    len = size(pointsBase, 1);
    distances = zeros(len, 1);
        
    for i = 1:len
        distances(i) = getDistance(pointsBase(i,:), queryPoint);
    end
    
    resultDistance = min(distances);
    pointIdx = find(distances == resultDistance);
    
    resultPoint = pointsBase(pointIdx(end), :);
end

