function [ enc ] = VLAD2PCA( vlad, adaptedCenters, coeff )
%VLAD2PCA Summary of this function goes here
%   Detailed explanation goes here

enc = coeff * (vlad-adaptedCenters);

end

