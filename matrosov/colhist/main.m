load('colhists');
hlist = holidaysList();

while 1
fname = hlist{ceil(rand(1)*numel(hlist))};
img = imread(fname);
distances = query(img, colhists);

[d, ix] = sort(distances);

h = colhist(img, 4);

%figure;
subplot(2,3,1); imshow(img);
for i=2:6
    subplot(2,3,i); imshow(imread(hlist{ix(i-1)}));
end

pause(1.5);
end