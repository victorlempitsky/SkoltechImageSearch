function [ results ] = searchInTrees( point, trees, topAmount )
% search for the nearest point in trees
% point - vector to search, trees - a set of trees to search 
% topAmount - amount of the results to return 
% results: cell array - column1 - point, column2 - ID, column3 - distance

    maxLeafsVisited = 100;
    
    treesAmount = numel(trees);
    
    results = cell(treesAmount, 1);
    
    for i = 1:treesAmount
        [ ~, ~, results{i}, leafsVisited ]...
                    = searchKDTree(trees{i}, point, maxLeafsVisited);   
    end
    
    results = vertcat(results{:});
    [~, sortIndexes] = sort(cell2mat(results(:, 3)));
    
    results = results(sortIndexes, :);
    
    results = results(1:topAmount, :);
end

