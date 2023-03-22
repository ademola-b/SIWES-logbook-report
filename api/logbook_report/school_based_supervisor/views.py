from django.shortcuts import render
from rest_framework.generics import ListAPIView
from . models import SchoolSupervisor
from . serializers import StudentListSerializer, SchoolSupervisorSerializer
from students.models import Student

# Create your views here.
class ProfileView(ListAPIView):
    queryset = SchoolSupervisor.objects.all()
    serializer_class = SchoolSupervisorSerializer

    def get_queryset(self, *args, **kwargs):
        qs = super().get_queryset()
        request = self.request
        user = request.user
        
        try:
            if not user.is_authenticated:
                SchoolSupervisor.objects.none()
            elif user.is_staff:
                SchoolSupervisor.objects.all()

            return qs.filter(user = request.user)
        except:
            return None
        
class StudentList(ListAPIView):
    queryset = Student.objects.all()
    serializer_class = StudentListSerializer

    def get_queryset(self, *args, **kwargs):
        qs = super().get_queryset(*args, **kwargs)
        request = self.request
        user = request.user
        
        if not user.is_authenticated:
            return Student.objects.none()
        elif user.user_type == 'school_based_supervisor':
            return qs.filter(school_based_supervisor = request.user.schoolsupervisor)
        return None