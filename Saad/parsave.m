%% This function is used to save variables in Parfor loop 

function [] = parsave(fname,data)
  save(fname,'data');
end