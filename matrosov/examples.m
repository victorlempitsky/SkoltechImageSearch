img = imread('img2.jpg');
img = imflatten(img);
imshow(img);
imwrite(img, 'img2f.png');