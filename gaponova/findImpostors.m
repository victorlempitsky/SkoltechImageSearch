function [negativeSet] = findImpostors(indNeg,cl,k)
% this function randomly takes k*2 negative examples for class
negativeSet=indNeg.(cl);
negativeSet=randsample(negativeSet,k*2);
end

