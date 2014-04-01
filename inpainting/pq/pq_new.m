function pq = pq_new (m, vectors)

numberOfVectors = size (vectors, 2);     
dimnension = size (vectors, 1);     % D, dimension of the gist vector
ds = dimnension / m;                % D/m , subdimension
nsqbits = 8;         
ks = 2^nsqbits;                     % number of centroids per subquantizer

pq.nsq = m;
pq.ks = ks;
pq.ds = ds;
pq.centroids = cell (m, 1);

for q = 1:m
    vs = vectors((q-1) * ds + 1 : q *ds, :);     % division into subsets
    [centroids_tmp, assign]= vl_kmeans(vs, ks);  % centeroids for the given subset
    pq.centroids{q} = centroids_tmp;
end
