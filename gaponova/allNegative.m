function [set] = allNegative(indCl,cl,numCl,numEx)
 
% Each query image is paired with each image from other classes, for large 
% datasets it will be computationaly expensive to compute loss of all
% dataset, so negative examples can be choosen by two ways. We can either
% compute loss of all dataset or we can compute loss of partial dataset.
% This function randomly choose 50% examples from each class
set=zeros(numEx-length(indCl.(cl)),1);
num=1;
indCl=rmfield(indCl,cl);
fn=fieldnames(indCl);

for i = 1:(numCl-1)
  ind=indCl.(fn{i});
  n=length(ind);
  set(num:num+n-1)=ind;
  num=num+n;
end

end

