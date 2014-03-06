% DO NOT RUN THIS SCRIPT EVER,
% IF ONLY YOU KNOW EXACTLY WHAT YOU ARE DOING!
%
% This script will run for a few days and during this process all tha data
% will be inconsistent, so you won't be able to get anything working.

disp('DO NOT RUN THIS SCRIPT!');
return;

computeMeans; V
computeEncodings1M; ?
adaptVLADs; X
computePCA4VLAD; V
computePCARepresentations; X
computePQ4PCA; X
computePQPCARepresentations; X