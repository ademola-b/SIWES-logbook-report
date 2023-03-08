from django.shortcuts import render
from rest_framework.generics import ListAPIView
from accounts.models import CustomUser
from api.models import LogbookEntry
from students.models import Student

from . serializers import StudentListSerializer, StudentLogbookEntrySerializer
# Create your views here.
class StudentList(ListAPIView):
    queryset = Student.objects.all()
    serializer_class = StudentListSerializer

    def get_queryset(self, *args, **kwargs):
        qs = super().get_queryset(*args, **kwargs)
        request = self.request
        user = request.user
        
        if not user.is_authenticated:
            return Student.objects.none()
        return qs.filter(industry_based_supervisor = request.user.industrysupervisor)


class LogbookEntryView(ListAPIView):
    queryset = LogbookEntry.objects.all()
    serializer_class = StudentLogbookEntrySerializer

    # def get_queryset(self):
        # user = self.request.user
    
        # # If user is not authenticated, return empty queryset
        # if not user.is_authenticated:
        #     return LogbookEntry.objects.none()
    
        # # If user is not a student, return empty queryset
        # if not hasattr(user, 'student'):
        #     return LogbookEntry.objects.all()
    
        # # Get the industry supervisor for the student
        # supervisor = user.student.industry_based_supervisor
    
        # # If student does not have an industry supervisor, return empty queryset
        # if supervisor is None:
        #     return LogbookEntry.objects.none()
    
        # # Filter logbook entries based on the industry supervisor
        # queryset = LogbookEntry.objects.filter(student__industrysupervisor=supervisor)
    
        # return queryset

    def get_queryset(self, *args, **kwargs):
        qs = super().get_queryset(*args, **kwargs)
        request = self.request
        user = request.user
        
        if not user.is_authenticated:
            return LogbookEntry.objects.none()
        # if user.user_type == 'industry_based_supervisor':
        #     LogbookEntry.objects.filter(student__industry_based_supervisor = request.user.industrysupervisor)
        return qs.filter(student__industry_based_supervisor = request.user.industrysupervisor)
        
    
    
