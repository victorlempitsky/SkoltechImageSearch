way='C:/Users/Tatiana/Desktop/dataset/pic_vlad/test';
path(way,path);
pics=dir(way);
load('pca.mat');
num=size(pics,1);
for k=3:num
    d=strcat(way,'/',num2str(k),'.mat');
    load(d);
    new=coef(1:256,:)*vlad;
    save(d,'new');
end