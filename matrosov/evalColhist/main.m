load('../data/colhists4');
hlist = holidaysList();

while 1
fname = hlist{ceil(rand(1)*numel(hlist))};
img = imread(fname);
distances = query(img, colhists);

[d, ix] = sort(distances);

h = colhist(img, 4);

%figure;
subplot(3,4,1); imshow(img);
for i=2:12
    subplot(3,4,i); imshow(imread(hlist{ix(i-1)}));
end

pause(1.5);
end