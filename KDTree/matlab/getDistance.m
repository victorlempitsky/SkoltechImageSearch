function [ distance ] = getDistance(point1, point2)
%calculate squared euclidian distance between two points
%the points must be vectors of the same dimensionality
    distance = sum((point1 - point2).^2);
end

