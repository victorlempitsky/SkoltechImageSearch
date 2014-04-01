function downloadph(tag)

output_dir = ['/home/m273/Vision/' tag '/'];

mkdir(output_dir);

rand('twister', sum(100*clock)); %seed random number generator


    tag = ['/home/m273/Vision/' tag '.txt'];
    
        fid = fopen(tag,'r');
        count=0;

        
        while 1
          line = fgetl(fid);
          if (~ischar(line))
            break
          end
          
            
          if strncmp(line,'photo:',6)
              
            
            count=count+1;
              
            first_line = line;
            
            [t,r] = strtok(line);
            [id,r] = strtok(r);
            [secret,r] = strtok(r);
            [server,r] = strtok(r);
            line = fgetl(fid);
            second_line = line;
            [t,r] = strtok(line);
            [owner,r] = strtok(r);
            
            f_comment = strvcat(first_line, ... %photo id secret server
                                    second_line,... %owner
                                    fgetl(fid)); %title
                  
            
            %large size

            url = ['http://static.flickr.com/' server '/' id '_' secret '_b.jpg'];
            cmd = ['wget -t 3 -T 5 --quiet ' url ...
                   ' -O ' '/tmp/' id '_' secret '_' server '_' owner '.jpg' ];
               
            try
                unix(cmd);
            catch
                lasterr
                fprintf('Wget does not work. Are you connected to the internet? \n');
            end

            
            
            f_info = dir(['/tmp/' id '_' secret '_' server '_' owner '.jpg']);
            output_filename = [tag '_'  id '_' secret '_' server '_' owner '.jpg' ];
            
            if(isempty(f_info))
                fprintf('Wget did not dwnload. Do we have free space in tmp? \n')
            else
                fsize = f_info.bytes;    
                
                if(fsize < 5000) %if we got an error .gif back we try original image
                   url = ['http://static.flickr.com/' server '/' id '_' secret '_o.jpg'];
                   cmd = ['wget -t 3 -T 5 --quiet ' url ...
                             ' -O ' '/tmp/' id '_' secret '_' server '_' owner '.jpg' ];                         
                   try
                       unix(cmd);
                   catch
                       lasterr
                       fprintf('Wget does not work. Are you connected to the internet? \n');
                   end
                    
                   f_info = dir(['/tmp/' id '_' secret '_' server '_' owner '.jpg']);
                   if(isempty(f_info))
                       fprintf('Wget did not dwnload. Do we have free space in tmp? \n')
                   else
                       fsize = f_info.bytes; 
                       
                       if(fsize < 5000) %error-gif?
                           file_is_ok = 0;
                       else
                           file_is_ok = 1;
                       end
                   end
                else
                    file_is_ok = 1;
                end

            
                if(file_is_ok == 1)
                    try
                        current_image = imread( ['/tmp/' id '_' secret '_' server '_' owner '.jpg' ] );
                    catch
                        lasterr
                        fprintf('error loading temporary file\n')
                    end

                            try
                                count
                                name = [output_dir tag '_' id '.jpg'];
                                imwrite(current_image, name, 'quality', 85, 'comment', f_comment);
                            catch
                                lasterr
                                fprintf('cannot write final image\n')
                            end
                        
                else
                    fprintf('No way with this picture \n');
                end
            end
            
            % delete the temporary file
            try
                delete(['/tmp/' id '_' secret '_' server '_' owner '.jpg' ]);
            catch
                lasterr
                fprintf('can not delete tempp file \n')
            end
            
            % to be chalant:
                    pause(1);
            
          end
        end
        
        fclose(fid);
        
    



