from django.urls import path

from . import views

urlpatterns = [
    path('', views.get_routes, name='endpoint'),
    path('program_date/', views.ProgramDateView.as_view(), name='Program Date'),
    path('week_dates/', views.WeekDatesView.as_view(), name='Week Dates'),
    path('week_comment/', views.WeekCommentView.as_view(), name='Week Dates'),
    path('logbook_entry/', views.LogbookEntryView.as_view(), name='logbook_entry'),
    path('entry_date/<str:date>/', views.LogbookWithDate.as_view(), name='entry_with_date'),
]
