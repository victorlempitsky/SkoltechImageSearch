function [loss] = tripletLoss(W,X,q,p,n)
loss=0;
L=1+computeDistP(W,X(:,q),X(:,p))-computeDistP(W,X(:,q),X(:,n));
if L>0
   loss=L;
end
end

