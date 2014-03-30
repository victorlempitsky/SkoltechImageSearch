function [adjmat, Z, pa, kdtreeNS] = return_chow_liu(centers, codebook)
Z = [];
kdtreeNS = KDTreeSearcher(centers','Distance','minkowski','P',5);
z_i_ones = [];
j = 1;
for i=1:size(codebook, 2)
    %for j=1:200
    if j<=200
        ind = knnsearch(kdtreeNS, codebook(:, i)');
        z_i_ones = [z_i_ones ind];
        j = j+1;
    else
        j = 1;
        z_i = zeros(1, 11000, 'double');
        for k=1:200
            tmp = z_i_ones(k);
            z_i(tmp) = 1;
        end
        Z = [Z; z_i];
        disp(size(Z));
        z_i_ones = [];
    end
end

values = [0, 1];
%[treeAdjMat, wij] = chowliuTree(Z, values);
[Ncases Nnodes] = size(Z);
weights = ones(1,Ncases);
[mi, nmi, pij, pi] = mutualInfoAllPairsDiscrete(Z, unique(Z(:)), weights);
[adjmat, cost] = minSpanTreePrim(-mi);

%create a directed version of the tree
root = 1;
Nstates = size(pi,2);
model.Nstates = Nstates;
model.Nnodes = Nnodes;
disp('here');
dirTree = mkRootedTree(adjmat, root);
disp('I built rooted tree');
pa = zeros(1, Nnodes);
CPDs = cell(1, Nnodes);
roots = [];
for n=1:Nnodes
  rents = parents(dirTree, n);
  if isempty(rents)
    pa(n) = 0;
    CPDs{n} = pi(n,:)';
    roots = [roots n];
  else
    p = rents;
    pa(n) = p;
    % can have at most one parent in a rooted tree
    CPDs{n} = squeeze(pij(p,n,:,:)) ./ repmat(pi(p,:)', 1, Nstates);
  end
end
%disp(model);
end