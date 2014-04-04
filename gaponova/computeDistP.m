function [dist] = computeDistP(W,X,Y)
% compute distance between two points
dist=norm(W*(X-Y));
end

