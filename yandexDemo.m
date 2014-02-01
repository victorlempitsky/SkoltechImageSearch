%31.01.14 created by Victor
%demos yandex image search querying
try
    ya_query = 'Skoltech';
    full_query = ['http://xmlsearch.yandex.ru/xmlsearch?user=skoltechcv&key=03.243528149:878ebdf341a06f978a021c738bbc1ff1.pv:fv:pi:fi:vir.d927b6c3ed3b9f6206c0296683482ad6&query='...
        ya_query '&type=pictures'];

    urlwrite(full_query, [getDataPath() 'temp/tmp.xml']);
    fileId = fopen([getDataPath() 'temp/tmp.xml']);

    matches = cell([1 0]);
    while ~feof(fileId)
        str = fgetl(fileId);
        matches = [matches regexp(str, '(<url>.*?</url>)','match')];
    end
    fclose(fileId);

    assert(~isempty(matches));
catch
    error('Querying went wrong. Perhaps running outside Skoltech network?');
end


for i = 1:numel(matches)
    try
        url = matches{i}(6:end-6); %remove xml tags
        dots = strfind(url,'.');
        fileext = url(dots(end)+1:end);
        target = [getDataPath() 'temp/tmp.' fileext];
        urlwrite(url, target);
        imshow(imread(target));
        pause;      
    catch
       continue; 
    end
end