function [] = runServer()

for i = 1 : 3
    runListener();
end

end

function [] = runListener()

t = tcpip('0.0.0.0', 30000, 'NetworkRole', 'server');
fopen(t);

newBytesNeeded = false;
doKillListener = false;
buffer = [];

while true
    while get(t, 'BytesAvailable') == 0
        pause(1);
    end
    data = uint8(fread(t, t.BytesAvailable, 'uchar'));
    buffer = [buffer; data];
    
    while ~newBytesNeeded && ~doKillListener
        newBytesNeeded = false;
        doKillListener = false;
        
        cmd = buffer(1);

        if cmd == 0
            try
                [M, bytesProcessed] = processMatrix(buffer(2 : end));
                disp(M);
%                 pause(10);
                buffer = buffer(2 + bytesProcessed : end);
            catch
                newBytesNeeded = true;
            end
            
        else
            doKillListener = true;  
            buffer = buffer(2 : end);
            
            lolStr = 'Die die die!';
            fwrite(t, typecast(int64(length(lolStr)), 'uint8'), 'uchar');
            fwrite(t, lolStr, 'char');
        end
    end
    
    if doKillListener
        break;
    end
end

fclose(t);
delete(t);
clear t;

end

function [M, bytesProcessed] = processMatrix(data)
    s = typecast(data(1 : 16), 'int64');
    
    try
        bytesToInterpret = s(1) * s(2) * 8;
        toInterpret = data(17 : 17 + bytesToInterpret - 1);
        
        M = typecast(toInterpret, 'double');
        M = reshape(M, s(2), s(1));
        M = M';
        
        bytesProcessed = bytesToInterpret + 16;
    catch err
        rethrow(err);
    end
end
