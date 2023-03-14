from django.shortcuts import render
from rest_framework import status
from rest_framework.generics import ListAPIView, ListCreateAPIView
from rest_framework.response import Response
from accounts.models import CustomUser
from api.models import LogbookEntry
from students.models import Student
from . models import (
    PlacementCentre, 
    IndustrySupervisor)

from . serializers import (StudentListSerializer, 
                           StudentLogbookEntrySerializer, 
                           PlacementCentreSerializer, 
                           IndustrySupervisorSerializer)

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
    
class PlacementCentreView(ListCreateAPIView):
    queryset = PlacementCentre.objects.all()
    serializer_class = PlacementCentreSerializer

    def post(self, request):
        placement_data = request.data
        data = {
            'name': placement_data['name'],
            'longitude': placement_data['longitude'],
            'latitude': placement_data['latitude'],
            'radius': placement_data['radius'],
        }
        placement_serializer = PlacementCentreSerializer(data=data)

        if placement_serializer.is_valid():
            placement = PlacementCentre.objects.create(
                        name=placement_data['name'], 
                        longitude=placement_data['longitude'], 
                        latitude=placement_data['latitude'], 
                        radius=placement_data['radius']
                        ) 
            
            user = request.user
            industry = IndustrySupervisor.objects.get(user=user)
            industry.placement_center = placement
            industry.save()
            # industry_serializer.save()
            placement_serializer.save()
            print(placement_serializer.data)

            return Response(placement_serializer.data, status=status.HTTP_201_CREATED) 
        else:
            return Response(placement_serializer.errors, status = status.HTTP_400_BAD_REQUEST)
