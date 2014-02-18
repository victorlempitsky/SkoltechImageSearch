__author__ = 'ivanovsergey'
import networkx as nx
import matplotlib.pyplot as plt
import random
import itertools

def bruteforce(G,k):
    ''' Find the most representative nodes using brute force
    Input: G -- networkx Graph object
    k -- number of vertices necessary to choose
    Output: best_comb1 -- nodes that maximize sum of distances between each other
    best_comb2 -- nodes that maximize minimum distance within
    best_sum -- maximal sum of distances within chosen set (corresponds to best_comb1)
    best_min_dist -- maximal minimum distance within chosen set (corresponds to best_comb2)
    Caveat: Don't use k large (less than 5 is ok for number of nodes equals 100)
    '''
    combs = itertools.combinations(range(len(G.nodes())), k)
    best_comb1 = []
    best_comb2 = []
    best_sum = 0
    best_min_dist = 0
    # used to track time
    import time
    start = time.time()
    threshold = 10**6
    t = 0
    for c in combs:
        nodes = c
        nodes_sum = 0
        nodes_min_dist = 10**8
        for i in range(len(nodes)-1):
            for j in range(i+1, len(nodes)):
                u = nodes[i]
                v = nodes[j]
                nodes_sum += G[u][v]['weight']
                nodes_min_dist = min(G[u][v]['weight'],nodes_min_dist)
        if nodes_sum > best_sum:
            best_sum = nodes_sum
            best_comb1 = list(nodes)
        if nodes_min_dist > best_min_dist:
            best_min_dist = nodes_min_dist
            best_comb2 = list(nodes)

        # signal time used when pass threshold
        t += 1
        if t == threshold:
            print 'Just calculated', threshold, 'combination'
            finish = time.time() - start
            print 'Used', finish, 'sec'
    finish = time.time() - start
    print 'Used', finish, 'seconds'
    return best_comb1, best_comb2, best_sum, best_min_dist

def greedy(G, k, metric=1):
    ''' Greedy algorithm to find the most representative vertices in a graph.
    Input: G -- networkx Graph object
    k -- number of vertices necessary to choose
    metric -- metric to measure distance for representative points
    metric = 1 is trying to maximize total distance between points in set
    metric = 2 is trying to maximize minimum distance between points in set
    Output:
    nodes -- set of representative vertices
    nodes_sum -- sum of distances in chosen set
    nodes_min_dist -- minimal distance between a pair of vertices of the set
    '''
    import operator
    n = len(G.nodes())
    m = len(G.edges())
    weights = dict() # weights of edges
    for u,v,d in G.edges(data=True):
        weights[(u,v)] = d['weight']
    # initialize first nodes
    ((u,v), w) = max(weights.iteritems(), key=operator.itemgetter(1))
    nodes = [u,v]
    # add nodes greedily
    while len(nodes) < k:
        maxv = maxi = -1 # value and index of new node
        for new_node in range(n):
            if new_node not in nodes:
                if metric == 1:
                    s = sum(map(lambda v: G[new_node][v]['weight'], nodes)) # metric 1: sum of distances to nodes
                elif metric == 2:
                    s = min(map(lambda v: G[new_node][v]['weight'], nodes)) # metric 2: min distance to nodes
                if s >= maxv:
                    maxv = s
                    maxi = new_node
        nodes.append(maxi)
    # calculate sum of distances in chosen set
    test = [53,81,10,28,26] # by mikhail solution
    nodes_sum = 0
    nodes_min_dist = 10**8
    for i in range(len(nodes)-1):
        for j in range(i+1, len(nodes)):
            u = nodes[i]
            v = nodes[j]
            nodes_sum += weights[(u,v)]
            nodes_min_dist = min(weights[(u,v)],nodes_min_dist)
    return nodes, nodes_sum, nodes_min_dist

if __name__ == '__main__':
    F = nx.complete_graph(100)
    G = nx.Graph()
    with open('distances.txt') as f:
        i = 0
        for line in f:
            dist = map(float, line.replace(',', '.').split())
            for (idx, d) in enumerate(dist[i+1:]):
                G.add_edge(i,idx+i+1, weight = d)
            i += 1
    print len(G.edges()), len(G.nodes())
    print greedy(G,3)
    print greedy(G,3,2)
    # for (u,v) in F.edges():
    #     G.add_edge(u,v, weight=random.randint(1,10**3))

    console = []