query_fname = [getDataPath(),'taster/fragment2.png'];
%query_fname = 'searchExample.jpg';

queryImg = imEqualizeHist(imread(query_fname));
sz = size(queryImg);

filelist = imgsList();
N = numel(filelist);

distances=Inf*ones(N,1);

wrongfiles = [];

for i=1:70000 % The first two elements are '.' and '..'
    fname = filelist{i};
    try
        img = imread(fname);

        isz = size(img);
        if isz(1)>=sz(1) && isz(2)>=sz(2)
            part = img(1:sz(1), 1:sz(2), :);
            part_f = imEqualizeHist(part);

            d = imgdiff(part_f, queryImg);
            distances(i) = d;
        else
            distances(i) = Inf;
        end

        if d<100
            fprintf('Probably it is %s, distance = %.2f\n', fname, d);
            imshow(imread(fname));
            pause(0.1); % wait while image will be displayed
        end

        % print progress
        if(mod(i,100)==0)
            if(mod(i,1000)==0)
                fprintf('%i\n', i);
            else
                fprintf('.');
            end
        end
    catch err
        wrongfiles{end+1} = fname;
        %fprintf('Cannot open %s\n', fname);
    end
end

[d, ix] = min(distances);

imshow(imread(filelist{ix}));
fprintf('%s, Distance = %.2f\n', filelist{ix}, d);

