function [encodings] = computeEncodings(sifts, means)

encodings = [];

% computing VLAD
for i=1:numel(sifts)
    encodings(:,end+1) = getBoW(sifts{i}, means);
    
    % print progress
    if(mod(i,100)==0)
        fprintf('.');
    end
end
fprintf('%i\n', i);

end