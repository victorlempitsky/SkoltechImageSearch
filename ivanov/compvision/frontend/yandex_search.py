import urllib, urllib2
from xml.dom import minidom

extensions = ['jpg', 'jpeg', 'bmp', 'tif', 'tiff', 'png', 'ico']

def query_url(text_query):
	return "http://xmlsearch.yandex.ru/xmlsearch?" + "user=skoltechcv&key=03.243528149:878ebdf341a06f978a021c738bbc1ff1.pv:fv:pi:fi:vir.d927b6c3ed3b9f6206c0296683482ad6" + "&query=%s&type=pictures" %text_query

def get_urls(text_query, n=8):
	url = query_url(urllib.quote(text_query))
	tree = minidom.parse(urllib2.urlopen(url))
	nodes = tree.getElementsByTagName('url')
	url_lst = []
	for node in nodes:
		url = node.firstChild.nodeValue.encode()
		ext = url.split('.')[-1]
		if ext.lower() in extensions:
			url_lst.append(url)
		if len(url_lst) == n:
			break
	return url_lst
