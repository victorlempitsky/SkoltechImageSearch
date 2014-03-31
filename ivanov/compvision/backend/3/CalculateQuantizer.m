clear all;
close all;

load('sifts.mat');



% %% Constructing vocabulary for m=16
% m = 16;
% DimReduced = 128/m;
% totalcentroids = 256;
% C_m16 = [];
% A_m16 = [];
% tic;
% for i = 1:m
%     [C_temp,A_temp] = vl_kmeans(sifts(((i-1)*DimReduced)+1:i*DimReduced,:), totalcentroids);
%     C_m16 = [C_m16;C_temp];
%     A_m16 = [A_m16;A_temp];
%     disp(strcat('i= ',num2str(i),'\n'));
% end
% save('Centroids_m16.mat', 'C_m16', 'A_m16');
% disp('m=16 done');
% toc;
%% Constructing vocabulary for m=8
tic;
m = 8;
DimReduced = 128/m;
totalcentroids = 256;
C_m8 = [];
A_m8 = [];
for i = 1:m
    [C_temp,A_temp] = vl_kmeans(sifts(((i-1)*DimReduced)+1:i*DimReduced,:), totalcentroids);
    disp(strcat('i= ',num2str(i),'\n'));
    C_m8 = [C_m8;C_temp];
    A_m8 = [A_m8;A_temp];
    
end
save('Centroids_m8.mat', 'C_m8', 'A_m8');
disp('m=8 done');
toc;