function [encodings] = computeEncodings(sifts, means)

encodings = [];

% computing VLAD
fprintf('Computing VLAD\n');
for i=1:numel(sifts)
    encodings(:,end+1) = getVLAD(sifts{i}, means);
    
    % print progress
    if(mod(i,100)==0)
        fprintf('.');
    end
end
fprintf('%i\n', i);

end