load ('/mnt/Data/VLADs/1')
load ('/mnt/Data/VLADs/filenames1')
load ('/mnt/Data/VLADs/clusters.mat')

N = numel(filenames);
W = 4;
H = 3;

while 1
    fname = filenames{ceil(N*rand())};
    img = imread(['/mnt/Images/', fname]);
    
    enc = getVLADFromImg(img, clusters);
    distances = vl_alldist2(enc, encodings);
    
    [distances,ix] = sort(distances);
    
    subplot(H,W,1); imshow(img);
    for i=2:W*H
        img = imread(['/mnt/Images/', filenames{ix(i-1)}]);
        subplot(H,W,i); imshow(img);
    end
    
    pause(2);
end