function FVs = encode_fvs(means, covariances, priors, sifts_pca)

FVs = vl_fisher(sifts_pca, means, covariances, priors, 'Improved');
