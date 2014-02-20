function [ grid ] = imgSet2imgGrid( img, w, N )

if nargin<3
    N = size(img,3);
end
if nargin<2
    w = ceil(sqrt(N));
end


h = ceil(N/w);

w1 = size(img,1);
h1 = size(img,2);

grid = zeros(w1*w, h1*h);

for i=1:w
    for j=1:h
        ix = i + w*(j-1);
        if ix <= N
            grid(w1*(i-1)+(1:w1), h1*(j-1)+(1:h1)) = img(:,:,ix);
        end
    end
end

end

