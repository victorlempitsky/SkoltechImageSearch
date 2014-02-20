clear

% read a fragment to match against
f = imread('/mnt/Data/taster/fragment1.png');
[m, n, l] = size(f);

% path to folders
datapath = '/mnt/Images/';
folders = {'1/', '2/', '3/', '4/', '5/', '6/', '7/'};
% folders = {'1/'};

breakid = 0; % used when found image
tic
for i = 1:numel(folders)
    path_cell= strcat(datapath,folders(i));
    path = path_cell{1}; %path to folder
    disp(['Proceed folder ' path]);
    Files = dir(path); 
    percent = .01; % used to format progress
    dec  = 1;  % used to format progress
    for k = 1:length(Files)
        try % when cannot open image
            filename_cell = strcat(datapath, folders(i), Files(k).name);
            filename = filename_cell{1};
            im = imread(filename);
            if isequal(f, im(1:m, 1:n, :)) % compare fragment and part of the image
                disp(['Found original picture in ' filename]);
                breakid = 1;
                break
            end
        catch
%             disp(['Cannot read file ' filename]);
        end
        % format progress
        if k == int16(percent*length(Files)*dec)
            fprintf('%2.1f%% ...\n', percent*dec*100);
            dec = dec + 1;
        end
        break
    end
    if breakid == 1
        break
    end
    break
end
toc
if breakid == 0
    disp('Original picture not found');
end

% Found original picture in /mnt/Images/6/238914818.2651129