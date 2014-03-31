%% Get list of files

Folder = '/mnt/Data/SIFTs/';
ImgFolders = dir(Folder);
ImgFolders = ImgFolders(3:end);
Imgs = [];

for i = 1:size(ImgFolders,1)
    iFolder = [Folder ImgFolders(i).name '/'];
    iImgs = dir(iFolder);
    iImgs = iImgs(3:end);
    for j = 1:size(iImgs,1)
        iImgs(j).name = [iFolder iImgs(j).name];
    end
    Imgs = [Imgs; iImgs];
end

save('Imgs.mat', 'Imgs');

disp('Imgs done.');