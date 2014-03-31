% This is a matlab tcp server to launch backends.
% Usage: Connect localhost:25771 and send a command.
% command 'clear' will clear everything except the server,
% command 'clear all' will also shutdown the server.

LOCAL_PORT = 25771;

tcpsocket = tcpip('0.0.0.0', LOCAL_PORT, 'NetworkRole', 'server');
fprintf('Server started on port %i\n', LOCAL_PORT);

fopen(tcpsocket);

while 1
    if tcpsocket.BytesAvailable
        try
            % read command
            data = fread(tcpsocket, tcpsocket.BytesAvailable);
            cmd = char(data');
            
            % print echo
            c = clock;
            fprintf('%i-%02i-%02i %02i:%02i:%02i \"%s\"\n', ...
                c(1), c(2), c(3), c(4), c(5), floor(c(6)), cmd);
            
            % workaround - we don't want to kill the server usually
            if strcmp(cmd, 'clear')
                clearvars -except tcpsocket;
                fprintf('Cleaned up.\n');
            else
                tic;
                eval(cmd);
                dt = toc;
                fprintf('Done in %.3f seconds.\n', dt);
            end
        catch err
            err
        end
        
        % reopen tcp
        fclose(tcpsocket);
        tcpsocket = tcpip('0.0.0.0', LOCAL_PORT, 'NetworkRole', 'server');
        fopen(tcpsocket);
    end
    
    pause(0);
end

fprintf('Server has been shut down\n');