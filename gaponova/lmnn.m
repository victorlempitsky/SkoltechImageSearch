function [bestW,W,bestL,initialL,finalL] = lmnn(X,Y,k,ep)
%LMNN - large margin nearest neighbor with dynamic assignment of
%neighbors
%X - training set mxn, where m is observations and n is features
%Training set is VLAD vectors
%Y - specification of classes, mx1 or 1xm cell-array, inputs - strings
%k - number of nearest neighbors
%ep - number of epochs


% list of all classes:
allCl=unique(Y); 
% number of classes
numCl=length(allCl);

[numF,numEx]=size(X);

% initializing the matrix: initially it represents euclidian distance (identity matrix)
W=eye(numF);

% constructing struct array that contains indexes of examples for each class
for i=1:numCl
    name=allCl{i};
    indCl.(name)=find(ismember(Y,allCl(i)));
end

% constructing struct array that contains indexes of negative examples for each classes
for i=1:numCl
    name=allCl{i};
    indNeg.(name)=allNegative(indCl,name,numCl,numEx);
end

% bestW and bestL will be updated as soon as we will find smaller loss
bestW=W;
initialL=lossPar(W,X,k,indCl,indNeg,numCl,allCl); 
bestL=initialL;

% during one epoch we pass only one random example of each class
for i=1:ep
    rate = 1/(i+1);
    for cl=1:numCl
        [q,p,n]=generateTriplets(W,X,k,indCl,indNeg,allCl,cl);
        for pos=1:length(p)
            for neg=1:length(n)
                trLoss=tripletLoss(W,X,q,p(pos),n(neg));
                if trLoss>0
                   grad=computeGrad(W,X,q,p(pos),n(neg));
                   W=W-rate*grad;
                end
            end
        end
        L=lossPar(W,X,k,indCl,indNeg,numCl,allCl);
        if L<bestL
            bestL=L;
            bestW=W;
        end
    end
end

finalL=lossPar(W,X,k,indCl,indNeg,numCl,allCl);

end

