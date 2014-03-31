Web Interface for class Building Large Scale Computer Vision System
===================================================================

To run server on 8000 port that listens to any other IP use:

```python manage.py runserver 0.0.0.0:8000```

Folders:
--------

* backend
* box
* compvision
* frontend


backend
---------
Responsible for communication between Matlab and Python. Each of folders inside is related to the common *waitFileServer.m* server.

box
---
Defines application *box* that consists of box model (database), redirecting urls, views (functioning). Read more on django app structure [here](https://docs.djangoproject.com/en/dev/intro/tutorial01/).

compvision
----------
Defines main setting for the whole project. Read more on django app structure [here](https://docs.djangoproject.com/en/dev/intro/tutorial01/#creating-a-project).

frontend
--------
Scripts to retrieve images from google (gr), yandex (yandex_search), communication via ports (runServer.m, runRequest.py, client.py), python matlab pipe (MatlabWrapper.m).

