DESCRIPTOR_ICON_SIZE = 64;

if ~exist('locations')
    load('sifts', 'locations');
end

load('filenames');

load('clusterCentersIDs');
%clusterCentersIDs = floor(rand(64,10)*1000000);
%cl_n = 0;

for ids = clusterCentersIDs
    clusterCenterImages = [];
    for i = 1:numel(ids);
        id = ids(i);
        imgN = floor(id/100000);
        d = mod(id, 100000);
        locs = locations{imgN};
        loc = locs(:,d);
        
        img = imread(filenames{imgN});
        if size(img,3)>1
            img = rgb2gray(img);
        end
        
        w = size(img,1);
        h = size(img,2);
        x = round(loc(2));
        y = round(loc(1));
        r = round(2*loc(3));
        
        patch = img(max(x-r,1):min(x+r,w), max(y-r,1):min(y+r,h));
        patch = histeq(patch);
        
        clusterCenterImages(:,:,i) = ...
            imresize(patch, [DESCRIPTOR_ICON_SIZE,DESCRIPTOR_ICON_SIZE]);
    end
    
    grid = imgSet2imgGrid(clusterCenterImages)/255.0;
    
    %imshow(grid); pause(0.5);
    cl_n = cl_n+1;
    imwrite(grid, sprintf('clusterizations/%d.png', cl_n));
end