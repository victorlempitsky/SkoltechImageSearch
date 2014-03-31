from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.template import RequestContext, loader
from django.core.urlresolvers import reverse
from django.utils import timezone

from box.models import Query, Url

import json, os, time, random
from frontend.yandex_search import get_urls
from frontend.gr import retrieveImages
from fifos.MatlabWrapper import mcmd, MatlabWrapper

INPUTNAME = '/home/ivanov/studies/django_projects/compvision/backend/input.txt'
INPUT_LOCK = '/home/ivanov/studies/django_projects/compvision/backend/input.lock'
OUTPUTNAME = '/home/ivanov/studies/django_projects/compvision/backend/output.txt'
OUTPUT_LOCK = '/home/ivanov/studies/django_projects/compvision/backend/output.lock'

# Create your views here.

def index(req):
    return render(req, 'box/index.html', {})

def search(req):
    text = req.POST['box']
    method = req.POST['methods']
    if text: 
        q = Query(search_text=text, search_date=timezone.now())
        q.save() # save to database

        url_lst = get_urls(text.encode('utf-8')) # retrieve urls from yandex
        for u in url_lst:
            q.url_set.create(url=u)
        
#        print 'Start of debugging'
        ########## debugging: delete after ###########
#        url_lst = []
#        print 'Before'
#        folders = random.sample(range(1,101), 8)
#        for folder in folders:
#            print folder
#            filename_folder = os.path.join('/mnt/Images/', str(folder))
#            filename = os.listdir(filename_folder)[0]
#            url_lst.append(os.path.join(filename_folder, filename))
        ########## end of debugging: delete before ##########
#        print 'End of debugging'

        # method 3 is not working yet
        if method == 3:
            method = 2
            
        # wait until there is no communication between Python and Matlab
        while True:
            if not os.path.exists(INPUTNAME) and not os.path.exists(INPUT_LOCK):
                with open(INPUTNAME, 'w') as f:
                    f.write(str(method) + os.linesep)
                    for u in url_lst:
                        f.write(u + os.linesep)
                open(INPUT_LOCK, 'a').close() # create input lock
                break
            time.sleep(0.1)
        print 'Created files for Matlab'
        # wait until Matlab outputs OUTPUT_LOCK
        while True:
            if os.path.exists(OUTPUT_LOCK):
                with open(OUTPUTNAME) as f:
                    pic_lst = [pic for pic in f]
                break
            time.sleep(0.1)
        # delete all files for the next process
        os.remove(OUTPUTNAME)
        os.remove(OUTPUT_LOCK)
        os.remove(INPUTNAME)
				
        # passing parameters to another view results through session
        # solution found here http://stackoverflow.com/a/8931063/2069858
        req.session['text'] = text
        req.session['url_lst'] = url_lst
        req.session['pic_lst'] = pic_lst
        req.session['method'] = method
        return redirect(reverse('box:results'))
    else:
        return render(req, 'box/index.html', {'error_message':
                                              'Please, specify a query'})

def results(req):
    text = req.session.get('text', '')
    url_lst = req.session.get('url_lst', [])
    method = req.session.get('method')
    pic_lst = req.session.get('pic_lst')
    if method == '1':
        top_pics = (pic_lst[8*i:8*(i+1)] for i in range(9))
        return render(req, 'box/1.html', {'query': text,
                                                'url_pic': zip(url_lst, *top_pics),
                                                'method': method,
                                                'range': range(len(url_lst))})
    elif method == '2':
        return render(req, 'box/2.html', {'query': text,
                                                'url': url_lst[0],
                                                'retrieved': pic_lst,
                                                'method': method,
                                                'range': range(len(url_lst))})
    elif method == '3':
        return render(req, 'box/2.html', {'query': text,
                                                'url': url_lst[0],
                                                'retrieved': pic_lst,
                                                'method': method,
                                                'range': range(len(url_lst))})
#        return render(req, 'box/3.html', {'query': text,
#                                            'url_pic': zip(url_lst, pic_lst),
#                                            'method': method,
#                                            'range' : range(len(url_lst))})
    elif method == '4':
        return render(req, 'box/4.html', {'query': text,
                                                'url_pic': zip(url_lst, pic_lst),
                                                'method': method,
                                                'range': range(len(url_lst))})
        
    
