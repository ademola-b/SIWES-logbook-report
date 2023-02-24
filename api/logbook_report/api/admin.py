from django.contrib import admin

from . models import WeekDates, LogbookEntry, ProgramDate, WeekComment
# Register your models here.
admin.site.register(ProgramDate)
admin.site.register(WeekDates)
admin.site.register(LogbookEntry)
admin.site.register(WeekComment)
