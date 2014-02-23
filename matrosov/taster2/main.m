load('../../clusterizations');
load('encodingsint8');
hlist = holidaysList();

means = clusterizations{1};

while 1
fname = hlist{ceil(rand(1)*numel(hlist))};
img = imread(fname);
distances = query( img, means, encodings );

[d, ix] = sort(distances);

%h = colhist(imEqualizeHist(img), 4);

subplot(3,4,1); imshow(img);
%subplot(1,2,2); bar(h);

%figure;
for i=1:11
    subplot(3,4,i+1); imshow(imread(hlist{ix(i)}));
end

pause(1);
end