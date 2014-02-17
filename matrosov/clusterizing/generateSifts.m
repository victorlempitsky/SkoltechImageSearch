load('filenames');

locations = {};
sifts = {};

for i=1:numel(filenames)
    fname = filenames{i};
    img = imread(fname);
    
    if size(img, 3)>1
        img = rgb2gray(img);
    end
    
    [F,D] = vl_sift(single(img));
    locations{i} = F;
    sifts{i} = D;
    
    % print progress
    if(mod(i,10)==0)
        if(mod(i,100)==0)
            fprintf('%i\n', i);
        else
            fprintf('.');
        end
    end
end