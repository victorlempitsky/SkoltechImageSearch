function [ found ] = PRfunc( in,n,output,relevant )

SizeRelevant=size(relevant,2);
SizeRetrieved=n;
found=0;

for i=(in:n)
    item=output(i,1:2);
    for j=(1:SizeRelevant)
        RelevantItem=relevant{j};
        if (item==RelevantItem)
            found=found+1;
        end
    end
end

% display(found);

% precision=found/SizeRetrieved;
% recall=found/SizeRelevant;


end

