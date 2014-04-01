function c = pq_assign (productQuantization, dataVectors)

n = size (dataVectors, 2);  
d = size (dataVectors, 1);
c = zeros (productQuantization.nsq, n, 'uint8');

for q = 1:productQuantization.nsq       %calculating distances for each subset quantizer
  
  % dividing dataset according to the D/m
  subVectors = dataVectors((q-1)*productQuantization.ds+1:q*productQuantization.ds, :);
  
vectorCentroids  = productQuantization.centroids{q};
vSub  = subVectors;
k  = 1;
  
n = size (vectorCentroids, 2); % number of centroids
nq = size (vSub, 2);             % number of subvectors

% calculating the distance

v_nr = sum (vectorCentroids.^2);   
q_nr = sum (vSub.^2);
dis = repmat (v_nr', 1, nq) + repmat (q_nr, n, 1) - 2 *vectorCentroids' * vSub;

%sorting based on distances

[dis, idx] = sort (dis);

dis = dis (1:k, :);
idx = idx (1:k, :);
  
  
  c(q, :) = idx - 1;
end
