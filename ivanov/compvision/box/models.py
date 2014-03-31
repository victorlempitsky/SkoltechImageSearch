from django.db import models

# Create your models here.

class Query(models.Model):
    search_text = models.CharField(max_length=128)   
    search_date = models.DateTimeField("date_search") 

    def __unicode__(self):
        return self.search_text

class Url(models.Model):
    query = models.ForeignKey(Query)
    url = models.URLField()

    def __unicode__(self):
        return self.url
