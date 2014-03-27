function [ node ] = createNode( dimNumber, dimValue, left, right )
% creates a kd-tree node
% dimNumber  - (integer) the number of spliting dimension 
% dimValue - (real) the splitting value
% left - (node) the left child of the node
% right - (node) the right child of the node
% isLeaf - (binary) 1 - when it is a leaf 0 - when it is not

    node = struct('dimNumber', dimNumber,...
                  'dimValue', dimValue,...
                  'left', left,...
                  'right', right,...
                  'isLeaf', false);
end

