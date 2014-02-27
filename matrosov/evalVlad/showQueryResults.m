addpath('../common');
load('means');
load('encodings');
load('../data/filenames');

N = numel(filenames);
W = 4;
H = 3;

while 1
    fname = filenames{ceil(N*rand())};
    img = imread(fname);
    
    distances = query( img, means, encodings );
    
    [distances,ix] = sort(distances);
    
    subplot(H,W,1); imshow(img);
    for i=2:W*H
        img = imread(filenames{ix(i-1)});
        subplot(H,W,i); imshow(img);
    end
    
    pause(1);
end