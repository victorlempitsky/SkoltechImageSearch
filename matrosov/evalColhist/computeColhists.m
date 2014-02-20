hlist = holidaysList();

chSizes = [8 12 16 24 32];
colhistsALL = {[], [], [], [], []};

% computing VLAD
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

    for k = 1:numel(chSizes);
        sz = chSizes(k);
        colhistsALL{k} = [colhistsALL{k},colhist(img, sz)];
    end

    % print progress
    if(mod(i,10)==0)
        if(mod(i,100)==0)
            fprintf('%i\n', i);
        else
            fprintf('.');
        end
    end
end

for k = 1:numel(chSizes);
    colhists = colhistsALL{k};
    save(['../data/colhists', num2str(chSizes(k))], 'colhists');
end
