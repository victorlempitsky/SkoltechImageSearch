%% load your sift file
load('\\srv-fs-01\students\denis.plotnikov\Desktop\CVProjectData\SIFTsArrayHolidays_TH5.mat');

% cut the set for testing
SIFTsArray = SIFTsArray(:, 1:8000);
treesNumber = 5;
trees = cell(treesNumber, 1);

setSize = size(SIFTsArray, 2);
aSet = single(SIFTsArray(:, 1:setSize))';

fileName = 'kdtree_';

clear SIFTsArray;

% determining the size of chunks
aSetChunkSize = ceil(setSize/treesNumber);

% making the trees
for i = 0:treesNumber - 2
    disp(['making tree ' num2str(i)]);
    tic;
    tree = ...
        buildKDTree(...
            aSet(i*aSetChunkSize + 1:(i+1)*aSetChunkSize, :),... 
            i*aSetChunkSize + 1:(i+1)*aSetChunkSize...
            );
        
    save([fileName num2str(i) '.mat'], 'tree', '-v7.3');
    toc;
    clear tree;
end

disp(['making tree ' num2str(treesNumber-1)]);
tic;
tree = ...
    buildKDTree(...
        aSet(i*aSetChunkSize + 1:(i+1)*aSetChunkSize, :),... 
        i*aSetChunkSize + 1:(i+1)*aSetChunkSize...
        );

save([fileName num2str(treesNumber - 1) '.mat'], 'tree', '-v7.3');
toc;

clear tree;
clear aSet;

for i = 0:treesNumber - 1
    data = load([fileName num2str(i) '.mat']);
    trees{i+1} = data.tree;
end

clear data;
clear fileName;
clear i;
clear treesNumber;
clear aSetChunkSize;
clear setSize;

disp('tree construction complete!');