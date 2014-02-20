function [ imgs ] = holidaysList( )

imgsdir = '/mnt/Images/Holidays';

dirlist = dir(imgsdir);
imgs={};
for i=1:numel(dirlist)
    if dirlist(i).bytes>0 && ~dirlist(i).isdir
        fname = [imgsdir, '/', dirlist(i).name];
        imgs{end+1} = fname;
    end
end

end

