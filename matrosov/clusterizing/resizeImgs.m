folder = 'imgs/jpg';

fnames = dir(folder);

filenames = {};

for i=3:numel(fnames)
    %fname = [folder, '/', fnames(i).name];
    %img = imread(fname);
    %img = imresize(img, 1024.0/max(size(img)));
    %imwrite(img, ['imgs/', fnames(i).name]);
    filenames{i-2} = ['imgs/', fnames(i).name];
end