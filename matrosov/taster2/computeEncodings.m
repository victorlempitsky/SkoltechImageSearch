% computeMeans();

load('means');

hlist = holidaysList();
encodings = [];

% computing VLAD
fprintf('Computing VLAD\n');
for i=1:numel(hlist)
    fname = hlist{i};
    try
        img = imread(fname);
    catch err
        continue;
    end
    
    if size(img,3)~=1 && size(img,3)~=3 || numel(size(img))>3
        continue; % skip this image. it is gif
    end
    if size(img,3)==3
        img = rgb2gray(img);
    end
    
    e%ncodings(:,end+1) = getByteho(img, means);
    encodings(:,end+1) = getVLAD(img, means);
    
    % print progress
    if(mod(i,10)==0)
        if(mod(i,100)==0)
            fprintf('%i\n', i);
        else
            fprintf('.');
        end
    end
end

%save('encodingsBH', 'encodings');
save('encodings', 'encodings');

