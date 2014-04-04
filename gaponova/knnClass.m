function [label] = knnClass(W,X,Y,query,k)
% k-NN classifier with learnt metric

label=0;
dist=computeDistM(W,X,query);
num=length(dist);


allCl=unique(Y); 
numCl=length(allCl);
for n=1:numCl
    clInd.(allCl{n})=n;
end

% variable 'ind' contains sorted indexes of positive examples in acsending
% order of distances
[~,ind]=sort(dist);

% elements of this vector corresponds to classes in the variable allCl
scores=zeros(1,numCl);

for i=1:num
    in=ind(i);
    index=clInd.(Y{in});
    scores(index)=scores(index)+1;
    if scores(index)==k
        label=Y{in};
        return
    end
end

end

