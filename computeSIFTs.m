run('/mnt/Software/vlfeat-0.9.17/toolbox/vl_setup.m');
h =waitbar(0,'Computing SIFTs');

for i = 40:100
    files = dir(['/mnt/Images/' num2str(i) '/']);
    outpath = [getDataPath 'SIFTs/' num2str(i) '/'];
    mkdir(outpath);
    waitbar(double((i-1)/100));
    for j = 3:numel(files)
        try 
            fname = ['/mnt/Images/' num2str(i) '/' files(j).name];
            outname = [outpath files(j).name];
            if exist(outname, 'file')
                continue;
            end
            im = single(rgb2gray(imread(fname)));
            tic
            [f d] = vl_sift(im);
            toc
            save(outname, 'f', 'd');
        catch
            continue;
        end
    end
end

close(h);
