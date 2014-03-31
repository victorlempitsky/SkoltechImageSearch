%% Constracting 256 vocabulary
load('sifts.mat')
[C_255_u, ~] = vl_kmeans(sifts(1:64,:), 255);
disp('Voc255u done.');
[C_255_d, ~] = vl_kmeans(sifts(65:128,:), 255);
disp('Voc255d done.');
save('vocabulary_255.mat', 'C_255_u', 'C_255_d');
disp('Voc255 done.');

