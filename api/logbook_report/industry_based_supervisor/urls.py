from django.urls import path

from . import views

urlpatterns = [
    path('students/', views.StudentList.as_view(), name='student_list'),
    path('logbook/', views.LogbookEntryView.as_view(), name='logbook_entry')
]
