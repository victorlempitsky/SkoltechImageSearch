%
% This is the modified implementation of code given the source below
%


% This function performs the search using the asymetric method (ADC) of a
% set vquery of vectors into a set cbase of codes encoded with pq
% Usage: [idx, dis] = pq_search (pq, cbase, vquery, k)
%
% Parameters:
%  pq       the pq structure
%  cbase    the codes indexing the vectors
%  vquery   the set of query vectors (one vector per column)
%  k        the number of k nearest neighbors to return
%
% Output: two matrices of size k*n, where n is the number of query vectors
%   ids     the identifiers (from 1) of the k-nearest neighbors
%           each column corresponds to a query vector. The row r corresponds 
%           to the estimated r-nearest neighbor (according to the algorithm)
%   dis     the *estimated* square distance between the query and the 
%           corresponding neighbor
%
% This software is governed by the CeCILL license under French law and
% abiding by the rules of distribution of free software. 
% See http://www.cecill.info/licences.en.html
%
% This package was written by Herve Jegou
% Copyright (C) INRIA 2009-2011
% Last change: February 2011. 



function [ids, dis] = pq_search (productQuantization, vectorData, queryVector, numberToReturn)
    
n = size (vectorData, 2);
nq = size (queryVector, 2);
d = size (queryVector, 1);

distab  = zeros (productQuantization.ks, productQuantization.nsq, 'single');
dis = zeros (nq, numberToReturn, 'single');
ids = zeros (nq, numberToReturn, 'single');

for query = 1:nq

  % pre-compute the table of squared distance to centroids
  for q = 1:productQuantization.nsq
    vsub = queryVector ((q-1)*productQuantization.ds+1:q*productQuantization.ds, query);
    qq = vsub;
    vv = productQuantization.centroids{q};
   
    number = size (vv, 2);
    dim = size (vv, 1);
    kk = number;

    % number of query vectors
    nqv = size (qq, 2);

    % Compute the square norm of the dataset vectors
    v_nr = sum (vv .* vv);

    % first compute the square norm the queries of the slice
    d_nr = sum (qq .* qq)';

    dis = repmat (v_nr, nqv, 1) + repmat (d_nr, 1, number) - 2 * qq' * vv;
    dis = repmat (v_nr, nqv, 1) + repmat (d_nr, 1, number) - 2 * qq' * vv;

    neg = find (dis < 0) ;

    dis(neg) = 0;
    
    distab(:,q) = dis;
    
  end 

  disquerybase = sumidxtab (distab, vectorData, 0);
  
  
  [val, idx] = sort (disquerybase);

    val = val (1:numberToReturn, :);
    idx = idx (1:numberToReturn, :);
  dis1 = val;
  ids1 = idx;
  
  dis = zeros (nq, numberToReturn, 'single');
ids = zeros (nq, numberToReturn, 'single');

  dis(query, :) = dis1;
  ids(query, :) = ids1;
end

