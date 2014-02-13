load('means');
load('encodingsBH');
hlist = holidaysList();

while 1
fname = hlist{ceil(rand(1)*numel(hlist))};
img = imread(fname);
distances = query( img, means, encodings );

[d, ix] = sort(distances);

%figure;
for i=1:6
    subplot(2,3,i); imshow(imread(hlist{ix(i)}));
end

pause(1);
end