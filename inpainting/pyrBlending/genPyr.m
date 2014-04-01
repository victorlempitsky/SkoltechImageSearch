function [ pyramid ] = genPyr( img, type, level )

pyramid = cell(1,level);
pyramid{1} = im2double(img);
for p = 2:level
	pyramid{p} = impyramid(pyramid{p-1}, 'reduce'); 
end

if strcmp(type,'gauss'), 
    return; 
end

for p = level-1:-1:1 
	origionalSize = size(pyramid{p+1})*2-1;
	pyramid{p} = pyramid{p}(1:origionalSize(1),1:origionalSize(2),:);
end

for p = 1:level-1
	pyramid{p} = pyramid{p}-impyramid(pyramid{p+1}, 'expand');
end

end