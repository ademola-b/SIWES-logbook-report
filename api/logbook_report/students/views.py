from django.shortcuts import render
from rest_framework.generics import ListAPIView
from . models import Student
from . serializers import StudentSerializer
# Create your views here.
class StudentView(ListAPIView):
    queryset = Student.objects.all()
    serializer_class = StudentSerializer

    def get_queryset(self, *args, **kwargs):
        qs = super().get_queryset()
        request = self.request
        user = request.user
        
        try:
            if not user.is_authenticated:
                Student.objects.none()
            elif user.is_staff:
                Student.objects.all()

            return qs.filter(user = request.user)
        except:
            return None
        
      
        
    