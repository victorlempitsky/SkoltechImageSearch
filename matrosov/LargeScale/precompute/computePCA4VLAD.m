load ('/mnt/Data/VLADs/1')

[coeff,score,latent,tsquared,explained,mu] = pca(encodings');

save('/mnt/Data/VLADs/pcaRoughData', 'coeff', 'latent', 'tsquared', 'explained', 'mu');

coeff = coeff(1:256, :);
latent = latent(1:256, :);

save('/mnt/Data/VLADs/pca', 'coeff', 'latent');