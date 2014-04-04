clear all
clc
 
load('training.mat');

coef=princomp(dataset');
pcaData=coef(1:256,:)*dataset;

tic
[bestW,W,bestL,initialL,finalL] = lmnn(pcaData,tags,5,100);
toc

save('lmnn5-100.mat','bestW','W','initialL','finalL');


tic
[bestW,W,bestL,initialL,finalL] = lmnn(pcaData,tags,3,100);
toc

save('lmnn3-100.mat','bestW','W','initialL','finalL');


tic
[bestW,W,bestL,initialL,finalL] = lmnn(pcaData,tags,10,100);
toc

save('lmnn10-100.mat','bestW','W','initialL','finalL');


tic
[bestW,W,bestL,initialL,finalL] = lmnn(pcaData,tags,5,50);
toc

save('lmnn5-50.mat','bestW','W','initialL','finalL');


tic
[bestW,W,bestL,initialL,finalL] = lmnn(pcaData,tags,5,150);
toc

save('lmnn3-150.mat','bestW','W','initialL','finalL');


tic
[bestW,W,bestL,initialL,finalL] = lmnn(pcaData,tags,5,200);
toc

save('lmnn5-200.mat','bestW','W','initialL','finalL');



