function [ vectors ] = tf_normalize( vectors )
%TF_IDF Summary of this function goes here
%   Detailed explanation goes here

means = mean(vectors, 2);

for i=1:numel(means)
    vectors(i,:) = vectors(i,:)/means(i);
end


end

