% Before running, set preferences -> parallel computing toolbox -> shut
% down ... after it is idle... = false;
% Run parpool(8) before running this script!

INPUT_LOCK = 'input.lock';
INPUT_FILE = 'input.txt';
OUTPUT_LOCK = 'output.lock';
OUTPUT_FILE = 'output.txt';

fprintf('Server started.\n');

while 1
    try
        if exist(INPUT_LOCK, 'file')
            c = clock;
            fprintf('%i-%02i-%02i %02i:%02i:%02i\n', ...
                c(1), c(2), c(3), c(4), c(5), floor(c(6)));
            
            query = fileread(INPUT_FILE);
            output = OUTPUT;
            backend;
            
            fd = fopen(output, 'w');
            fprintf(fd, '%s', result);
            fclose(fd);
            
            delete(INPUT_LOCK);
            fclose(fopen(OUTPUT_LOCK, 'w'));
        end
    catch err
        err
    end
    
    pause(0);
end
