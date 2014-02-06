function [datapath] = getDataPath()
%returns a slash ending path to the folder containing subfolders with various data
% (both images and computed data)
%31.01.14 created by Victor
[~,out] = system('hostname');

if strcmp(out(1:4), 'ts-l')
    datapath = '/mnt/Data/';
elseif strcmp(out(1:8),'vilem-pc')
    datapath = 'E:\Code\ImageSearchData\';
elseif strcmp(out(1:7),'iceberg')
    datapath = '/home/m273/SkVisual/Data';
elseif strcmp(out(1:5), 'medan')
    datapath = '/Users/mikhail/Projects/SkoltechImageSearch/';
end  %insert your computer names here using elseif (mind the trailing symbol!)
    
