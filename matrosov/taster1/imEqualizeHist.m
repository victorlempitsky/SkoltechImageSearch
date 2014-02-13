function [ img ] = imEqualizeHist( img )
% Changes image's color so its histogram becomes flat

% check number of channels
if numel(size(img))==2
    img = reshape(img, [size(img),1]);
end

% for each color channel
for channel=1:size(img,3)
    img(:,:,channel) = histeq( img(:,:,channel) );
    
    % i = img(:,:,channel);
    %h = hist(i(:),0:255); % its histogram
    %cs = cumsum(h); % integrate
    %cs = round(cs*255/cs(end)); % normalize histogram that max=255
    %cc(:,channel) = cs;
    %i(:) = cs(i(:)+1); % shift colors - the histogram will become flat
    %img(:,:,channel) = i;
end

end

