function [grad] = computeGrad(W,X,q,p,n)

q_p=X(:,q)-X(:,p);
q_n=X(:,q)-X(:,n);
tic
grad=2*W*(q_p*(q_p')-q_n*(q_n'));
toc
end

