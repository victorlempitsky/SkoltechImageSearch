clear all;
close all;

Folder = '/mnt/Data/SIFTs/';
ImgFolders = dir(Folder);
ImgFolders = ImgFolders(3:end);
sz = 0;
for i = 1:size(ImgFolders,1)
    iFolder = [Folder ImgFolders(i).name '/'];
    iImgs = dir(iFolder);
    sz = sz + numel(iImgs);
end

disp('NumImages:',num2str(sz));