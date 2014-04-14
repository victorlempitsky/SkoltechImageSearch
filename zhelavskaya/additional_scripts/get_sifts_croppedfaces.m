imagesFolder = '/mnt/CroppedFaces';

if (exist(imagesFolder, 'dir'))
    
    d = dir(imagesFolder);
    isub = [d(:).isdir];
    namefolds = {d(isub).name}';
    
    for j = 4 : length(namefolds),%3
        disp(['Folder #', num2str(j - 2)])
        D = dir([strcat(imagesFolder, '/', namefolds{j}), '']);
        numFiles = length(D(not([D.isdir])));
        
        name_fold = ['/mnt/CroppedFaces_sifts/', namefolds{j}];
        mkdir(name_fold)
        
        for i = 3 : numFiles + 2,
            disp([num2str(i - 2)])
            im_path = strcat(imagesFolder, '/', namefolds{j}, '/', D(i).name);
            
            try
                im = imread(im_path);
            catch err
                if (strcmp(err.identifier,'MATLAB:imagesci:jpg:cmykColorSpace'))
                    continue;
                else
                    rethrow(err);
                end
            end
            
            if length(size(im)) == 3
                I = rgb2gray(im);
                I = single(I);
            elseif length(size(im)) == 2
                I = single(I);
            end
        
            sift_features_dense = extract_sifts({I});
        
            name = [name_fold, '/', D(i).name, '.mat'];
            save(name, 'sift_features_dense')
        
        end,
        
    end
else
    
    trueImage = -1;
    trueImage_path = -1;
    disp('Error: check name of your paths. Something does not exist.');
    
end