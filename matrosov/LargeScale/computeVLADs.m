siftsdir = '/mnt/Data/RootSIFTs';
vladsdir = '/mnt/Data/VLADs';
imgsdir  = '/mnt/Images';

load([vladsdir,'/clusters']);

for dirNumber = 1:100
    dirlist = dir(sprintf('%s/%d', siftsdir, dirNumber));
    filenames={};
    encodings = single([]);
    
    for i=1:numel(dirlist)
        if dirlist(i).bytes>0 && ~dirlist(i).isdir
            fname = sprintf('%d/%s', dirNumber, dirlist(i).name(1:end-4));
            filenames{end+1} = fname;
            
            load(sprintf('%s/%s.mat', siftsdir, fname));
            
            encodings(:,end+1) = getVLAD(d, clusters);
        end
        
        if mod(i,1000)==0
            fprintf('.');
        end
    end
    
    save(sprintf('%s/filenames%d.mat', vladsdir, dirNumber), 'filenames');
    save(sprintf('%s/%d.mat', vladsdir, dirNumber), 'encodings');
    
    fprintf(' Directory %d is done\n', dirNumber);
end