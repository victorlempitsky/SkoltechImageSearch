#!/usr/bin/python

import sys, string, math, time, socket
from flickrapi2 import FlickrAPI
#from convert import int2str

socket.setdefaulttimeout(30)
#30 seconds before sockets throw an exception.
#Flickr servers can be slow

flickrAPIKey = ""  # API key
flickrSecret = ""                  # shared "secret"

#query_string=sys.argv[1]

f = open('./final-tags')
line = f.readline()
e = 0
while line:
    e = e+1
    print e
    print (line)
    line = f.readline()
    query_string = line.strip()
    output_filename = './Vision/' + query_string + '.txt'
    out_file = open(output_filename,'w')

    fapi = FlickrAPI(flickrAPIKey, flickrSecret)

    i = 0

    page_num = range(1,5)

    for i in page_num: 

        page_nu = str(i)

        try:
            rsp = fapi.photos_search(api_key  = flickrAPIKey,
                                     ispublic = "1",
                                     media    = "photos",
                                     per_page = "250", #seems like it is max
                                     page     = page_nu,
                                     text     = query_string)
            time.sleep(1)
            fapi.testFailure(rsp)
            total_images = rsp.photos[0]['total']

            for b in rsp.photos[0].photo:
                if b!=None:
                    out_file.write('photo: ' + b['id'] + ' ' + b['secret'] + ' ' + b['server'] + '\n')
                    out_file.write('owner: ' + b['owner'] + '\n')
                    out_file.write('title: ' + b['title'].encode("ascii","replace") + '\n')
                    out_file.write('tags: ' + b['tags'].encode("ascii","replace") + '\n')


                    out_file.write('\n')

        except KeyboardInterrupt:
            print("KeyboardInterrupt. Closing.")
            exit(0)
        except Exception as e:
            print e
            exit(1)


    out_file.close


f.close()

