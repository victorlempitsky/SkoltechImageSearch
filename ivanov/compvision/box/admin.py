from django.contrib import admin
from box.models import Query, Url

# Register your models here.

class UrlsInline(admin.TabularInline):
    model = Url
    extra = 0

class QueryAdmin(admin.ModelAdmin):
    fields = ['search_text']
    inlines = [UrlsInline]
    list_display = ('search_text', 'search_date')
    list_filter = ['search_date']
    search_field = ['search_text']

admin.site.register(Query, QueryAdmin)
