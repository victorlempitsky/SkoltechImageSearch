run('vlfeat-0.9.18/toolbox/vl_setup');
run('pmtk3-master/initPmtk3');
load('centers_im.mat');
load('codebook_im.mat');
load('names_im.mat'); %recalculate
load('adjmat_im.mat');
load('Z_im.mat');
load('pa_im.mat');
load('kdtreeNS_im.mat');
%[centers, codebook, names] = bag_of_words();
%[adjmat, Z, pa, kdtreeNS] = return_chow_liu(centers, codebook);
prior = calculate_prior_probabilities(Z);
M = mean(prior, 1);
dif_prob = calculate_dif_prob(Z);
Z_test = test_bag_of_words(kdtreeNS);
[probabilities, root_prob] = calculate_probabilities(Z, pa, Z_test, prior);
result_db_prob = calculate_result_prob_for_db(root_prob, probabilities, dif_prob, Z);
