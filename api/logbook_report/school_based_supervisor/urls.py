from django.urls import path
from . import views
from industry_based_supervisor.views import LogbookEntryView

urlpatterns = [
    path('profile/', views.ProfileView.as_view(), name='profile'),
    path('students/', views.StudentList.as_view(), name='student_list'),
    path('logbook/', LogbookEntryView.as_view(), name='logbook_entry'),

]


