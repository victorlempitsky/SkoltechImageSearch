function [totalLoss] = lossPar(W,X,k,indCl,indNeg,numCl,allCl)
%LOSS loss function for LMNN
totalLoss=0;
for m=1:numCl
    cl=allCl{m};
    [~,distP]=findNeighbors(W,X,k,indCl.(cl),m);
    negativeSet=findImpostors(indNeg,cl,k);
    l=length(negativeSet);
    distN=computeDistM(W,X(:,negativeSet),X(:,m));
    
    for p=1:k
        for n=1:l
            L=1+distP(p)-distN(n);
            if L>0
               totalLoss=totalLoss+L;
            end    
        end
    end
end

end

