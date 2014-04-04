function [dist] = computeDistM(W,X,Y)
% Compute multiple distances between set of points X and one point Y

substractedX=bsxfun(@minus,X,Y);
dist=sqrt(sum((W*substractedX).^2,1));

end

