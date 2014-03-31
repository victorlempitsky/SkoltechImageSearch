load('/mnt/Data/arutar/HASH/sifts');

N = size(sifts,2);

sifts = uint8(sifts);

minDist = zeros(1,N);

tic();

for i=3*N/4+1:N
    s = sifts(:,i);
    sifts(:,i) = 0; % get out
    minDist(i) = min(vl_alldist2(s, sifts));
    sifts(:,i) = s; % push back
    
    if mod(i,10)==0
        if mod(i,100)==0
            fprintf('%d, %.2f s\n', i, toc());
            tic();
        else
            fprintf('.');
        end
    end
end

save('minDist4', 'minDist');
