close all
clear



imgA = im2double(imread('holidayS1/ac.jpg')); 
imgB = im2double(imread('holidayS1/bb.jpg'));
customRegion = im2double(imread('holidayS1/acrb.jpg'));

% imgB = im2double(imread('holidayS1/bb.jpg'));
% imgA = im2double(imread('holidayS1/b.jpg')); 
% customRegion = im2double(imread('holidayS1/r.jpg'));

% imgB = im2double(imread('b.jpg'));
% imgA = im2double(imread('a.jpg')); % size(imga) = size(imgb)
% customRegion = im2double(imread('r.jpg'));


% imgB = im2double(imread('102600.jpg'));
% imgA = im2double(imread('102601.jpg')); 
% customRegion = im2double(imread('bw.jpeg'));







% lapImageB = genPyr(imgb,'lap',level);
% mask = 1-customRegion;
% blurh = fspecial('gauss',30,15); % feather the border
% customRegion = imf

imgB = imresize(imgB,[size(imgA,1) size(imgA,2)]);
[M N ~] = size(imgB);


v = 230;
level = 5;
lapImageA = genPyr(imgB,'lap',level); 
lapImageB = genPyr(imgA,'lap',level);


mask = 1-customRegion;
blurh = fspecial('gauss',30,15); 
customRegion = imfilter(customRegion,blurh,'replicate');
mask = imfilter(mask,blurh,'replicate');

% After filter, images A and B are multiplied masks as filter and added to
% each other.

lapImages = cell(1,level); 
for p = 1:level
	[Mp Np ~] = size(lapImageA{p});
	maskap = imresize(customRegion,[Mp Np]); % for image A
	maskbp = imresize(mask,[Mp Np]);         % for image B
	lapImages{p} = lapImageA{p}.*maskap + lapImageB{p}.*maskbp;
end

% image reconstruction. Addition of laplacian images, created in previous
% step.

for p = length(lapImages)-1:-1:1
	lapImages{p} = lapImages{p}+impyramid(lapImages{p+1}, 'expand');
end

% final images is at level 1
imgo = lapImages{1};

figure,imshow(imgo) 