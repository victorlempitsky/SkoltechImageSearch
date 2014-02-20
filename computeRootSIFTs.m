%run('/mnt/Software/vlfeat-0.9.17/toolbox/vl_setup.m');
h =waitbar(0,'Computing RootSIFTs');

for i = 1:100
    files = dir([getDataPath 'SIFTs/' num2str(i) '/']);
    outpath = [getDataPath 'RootSIFTs/' num2str(i) '/'];
    mkdir(outpath);
    waitbar(double((i-1)/100));
    for j = 3:numel(files)
        try 
            fname = [getDataPath 'SIFTs/' num2str(i) '/' files(j).name];
            
            outname = [getDataPath 'RootSIFTs/' num2str(i) '/' files(j).name '.mat'];
            if exist(outname, 'file')
                continue;
            end
            load(fname, '-mat');
            d = single(d);
            d = bsxfun(@times, d, 1./sum(abs(d)));
            d = sqrt(d);
            save(outname, 'f', 'd');
        catch
            continue;
        end
    end
end

close(h);
