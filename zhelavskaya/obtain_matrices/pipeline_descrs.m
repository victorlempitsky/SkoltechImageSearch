% Pipeline for obtaining descriptors

file_people = '/data_lfw/peopleDevTrain.txt';
file_pairs = '/data_lfw/pairsDevTrain.txt';

%% I Dense SIFTs
% 
% 1.a Extract SIFTs densely. Here we obtain ~36K 128-dimensional descriptors per 
% face (and we save them in the appropriate folders).
[face_region_set, peopleToFV] = get_sifts_train_v2(file_people);    % done


%% II PCA matrices
% 
% 2.a Randomly select 100,000 SIFTs from the set
[sifts_dense_for_pca] = get_random_sifts(file_people);

% 2.b Conducting PCA to get the compression matrix so that 128-d --> 64-d
% (on these randomly selected SIFTs)
[VV, fr, B] = conduct_pca(sifts_dense_for_pca);                     % done
% save '/mnt/sifts_matrices/pca2' VV fr B


%% III Train GMMs
% 
% 3.a Randomly select some new 100,000 SIFTs
[sifts_dense_for_pca2] = get_random_sifts(file_people);             % done

% 3.b Apply the obtained matrix of PCA (to some new 100,000 SIFTs)
[sift_features, Y] = apply_pca(VV, sifts_dense_for_pca2);
% save '/mnt/sifts_matrices/sift_features2' sift_features Y

% 3.c Learn GMMs
[means, covariances, priors] = train_gmms(Y);                       % done
% save '/mnt/sifts_matrices/gmms2' means covariances priors

%% IV Fisher vectors
% 
% 4.a Apply the obtained matrix of PCA (to all SIFTs and all images)
[k] = get_all_pcas(VV, file_people);                                % done

% 4.b Encode all vectors with obtained GMMs
[FVs] = encode_fvs(means, covariances, priors, file_people);        % done
% save('/mnt/sifts_matrices/FVs2', 'FVs', '-v7.3')


%% V Metrics learning
% 
% 5.a Initialize matrix W
W_init = init_W(FVs);
% save '/mnt/sifts_matrices/w_init2' W_init

% 5.b Run stochastic sub-gradient descend and learn the metrics
update_FV_to_people;
W = dim_reduction(num_samp, W_init, FVs, gamma, num_iters, scannedData_pos, scannedData_neg);
% save '/mnt/sifts_matrices/w' W









