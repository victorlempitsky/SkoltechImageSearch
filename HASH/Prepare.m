%% Combine all maps for images into one, works only for 300000 images :(

hm = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

for i = 1:50
    load(['sketches_100k_' num2str(i) '.mat'], 'arr');
    
    for j = 1:length(arr)
        keys = arr{j}.keys;
        values = arr{j}.values;
        
        for k = 1:length(keys)
            if hm.isKey(keys{k})
                hm(keys{k}) = uint32([hm(keys{k}) values{k}]);
            else
                hm(keys{k}) = uint32(values{k});
            end
        end
    end
    
    save(['hm_500k_' num2str(i) '.mat'], 'hm')
end



