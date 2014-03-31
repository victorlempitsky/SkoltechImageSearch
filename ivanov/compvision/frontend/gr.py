''' Retrieve images from Google Images. '''

import os
import errno
import urllib, urllib2
import simplejson
import requests

QUERYURL = "https://ajax.googleapis.com/ajax/services/search/images?"

# lowercase supported images formats
extensions = ['jpg', 'jpeg', 'bmp', 'tif', 'tiff', 'png', 'ico']

def mkdir(path, ow=False):
    ''' Creates new directory in path.
    Input: path -- name of directory (string)
    ow -- overwrite parameter (default to false)
    Source: http://stackoverflow.com/questions/273192/check-if-a-directory-exists-and-create-it-if-necessary
    '''
    try:
        os.makedirs(path)
    except OSError as exception:
        if exception.errno != errno.EEXIST:
            raise
        if ow:
            import shutil
            shutil.rmtree(path)
            mkdir(path, False)
        
def extractData(response):
    ''' Extract data from JSON response.
    '''
##    results = simplejson.load(response)
    print results
    data = results['responseData']
    print data
    return data['results']

def retrieveImages(query, n=8, ow=False):
    ''' Retriecve images from Google Images and save them under the same name folder.
    query -- search query (string)
    n -- number of images
    ow -- overwrite parameter for folder of storage
    '''
    # make directory for images
##    mkdir(query, ow)
    # replace spaces, some punctuation, etc.
    # searchTerm = urllib.quote(query)
    searchTerm = query.replace(' ', '%20')
    # number of foursomes proceeded
    foursome = 0
    # number of pictures stored
    pics = 0
    # list of filenames
    url_lst = []
    while True:
        # necessary parameters for query url
        params = urllib.urlencode({'v': '1.0',
                                   'start': str(foursome*4)})
        url = QUERYURL + params + '&q=' + searchTerm # enchance for multilanguage

        json = requests.get(url).json()
##        request = urllib2.Request(url, None, {'Referer': 'testing'})
##        response = urllib2.urlopen(request)

##        d = extractData(json)
##        print json
        d = json['responseData']['results']
        # retrieve and save image
        for myURL in d:
            # extract url of picture
            pic_url = myURL['unescapedUrl']
##            print pic_url
            # check availability of extension
            ext = pic_url.split('.')[-1] # images format
            if ext.lower() not in extensions:
                continue
            # download image
            try:
                path = os.path.join(query, str(pics+1)+'.'+ext)
##                urllib.FancyURLopener().retrieve(pic_url, path)
            except:
                print 'Have problems with retrieving the page'
            else:
                pics += 1
                url_lst.append(pic_url)
                
            if pics == n:
                return map(lambda u: u.encode(), url_lst)

        foursome += 1


if __name__ == '__main__':
    searchTerm = 'galaxy'
    foursome = 0
    params = urllib.urlencode({'v': '1.0',
                                   'start': str(foursome*4)})
    url = QUERYURL + params + '&q=' + searchTerm # enchance for multilanguage
    request = urllib2.Request(url, None, {'Referer': 'testing'})
    response = urllib2.urlopen(request)
