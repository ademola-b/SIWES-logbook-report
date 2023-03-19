from django.shortcuts import render
from rest_framework.generics import ListAPIView
from . serializers import StudentListSerializer
from students.models import Student

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
        elif user.user_type == 'school_based_supervisor':
            return qs.filter(school_based_supervisor = request.user.schoolsupervisor)
        return None