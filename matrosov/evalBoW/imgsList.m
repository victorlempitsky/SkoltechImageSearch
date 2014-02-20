function [ imgs ] = imgsList( )

imgsdir = '/mnt/Images';

dirlist = dir(imgsdir);
imgs={};
for i=1:5 %numel(dirlist)-3 % 5 folders is more than enough
    foldername = [imgsdir, '/', num2str(i)];
    filenames = dir(foldername);
    for j=3:numel(filenames)
        imgs{end+1} = [foldername, '/', filenames(j).name];
    end
end

end

