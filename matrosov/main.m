foldername = 'oxbuild_images';
query_fname = 'imgq.jpg';

filelist = dir(foldername);
N = numel(filelist);

queryImg = imEqualizeHist(imread(query_fname));
sz = size(queryImg);

distances=[Inf, Inf];

for i=3:N % The first two elements are '.' and '..'
    fname = filelist(i).name;
    img = imread([foldername,'/',fname]);
    
    isz = size(img);
    if isz(1)>=sz(1) && isz(2)>=sz(2)
        part = img(1:sz(1), 1:sz(2), :);
        part_f = imEqualizeHist(part);

        d = mean(mean(mean( (double(part_f)-double(queryImg)).^2 )));
        distances(i) = d;
    else
        distances(i) = Inf;
    end
    
    if(mod(i,50)==0)
        disp(i);
    end
end

[d, ix] = min(distances);

imshow([foldername,'/',filelist(ix).name]);
fprintf('%s, Distance = %.2f\n', filelist(ix).name, d);

