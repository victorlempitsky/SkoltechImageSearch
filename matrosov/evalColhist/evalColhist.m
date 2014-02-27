addpath('../common');
load('../data/holidaysLabels');
load('../data/colhists32');

mAP = getMAP(labels, colhists);

fprintf('For color histogram mAP = %.4f\n', mAP);
