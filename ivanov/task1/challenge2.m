clear

% read a fragment to match against
f = imread('/mnt/Data/taster/fragment2.png');
med_f = median(reshape(f, [], 1));
[m, n, l] = size(f);

% set of pictures that match well
matches = {};
mt = 0;

% path to folders
datapath = '/mnt/Images/';
% datapath = './';
folders = {'1/', '2/', '3/', '4/', '5/', '6/', '7/'};
% folders = {'4/'};
% folders = {'Pics/'}

tic
for i = 1:numel(folders)
    path_cell= strcat(datapath,folders(i));
    path = path_cell{1}; %path to folder
    disp(['Proceed folder ' path]);
    Files = dir(path);
    disp(['Found ' num2str(length(Files)) ' files in the folder']);
    percent = .01; % used to format progress
    dec  = 1;  % used to format progress
    for k = 1:length(Files)
        try % when cannot open image
            filename_cell = strcat(datapath, folders(i), Files(k).name);
            filename = filename_cell{1};
            im = imread(filename);
            imf = im(1:m, 1:n, :);
            med_im = median(reshape(imf, [], 1));
            breakid = 0;
            for r = 1:30
                i1 = randi(size(f,1));
                i2 = randi(size(f,2));
                i3 = randi(size(f,3));
                
                b1 = f(i1,i2,i3) <= med_f;
                b2 = imf(i1,i2,i3) <= med_im;
                if b1 + b2 == 1 % if images has "different" pixel
                    breakid = 1;
                    break
                end
            end
            if breakid == 0
                disp(['Found original picture in ' filename]);
                break
            end
        catch
%             disp(['Cannot read file ' filename]);
        end
        if k == int16(percent*length(Files)*dec)
            fprintf('%2.1f%% ...\n', percent*dec*100);
            dec = dec + 1;
        end
    end
    if breakid == 0
        break
    end
end
toc
if breakid == 1
    disp('Original picture not found');
end

% Found original picture in /mnt/Images/4/44698113.481269