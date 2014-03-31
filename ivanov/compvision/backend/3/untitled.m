
QuantizationFolder = '/mnt/Data/ProductQuantization/ProductQuantizers/';
ImgFolders = dir([QuantizationFolder '*QIndex*']);

for i = 2:size(ImgFolders,1)
    QuantizerIndex_2 = load([QuantizationFolder ImgFolders(i).name]);
    n = fieldnames(QuantizerIndex_2);
    f.(['QuantizerIndex_',num2str(i)]) = f.(n{1});
    f = rmfield(f,n{1});
   % save([QuantizationFolder,'QIndex_',num2str(i),'.mat'],'f','-mat');
    
end