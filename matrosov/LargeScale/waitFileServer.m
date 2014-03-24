% Before running, set preferences -> parallel computing toolbox -> shut
% down ... after it is idle... = false;
% Run parpool(8) before running this script!

LOCK_FILE = 'lock';
QUERY_FILE = 'query.txt';
OUTPUT = 'output.txt';

fprintf('Server started on port %i\n', LOCAL_PORT);

while 1
    try
        if exist(LOCK_FILE, 'file')
            c = clock;
            fprintf('%i-%02i-%02i %02i:%02i:%02i\n', ...
                c(1), c(2), c(3), c(4), c(5), floor(c(6)));
            
            query = fileread(QUERY_FILE);
            output = OUTPUT;
            backend;
            delete(LOCK_FILE);
        end
    catch err
        err
    end
    
    pause(0);
end
