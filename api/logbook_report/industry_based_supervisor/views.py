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

from students.serializers import StudentSerializer

# Create your views here.
class StudentList(ListAPIView):
    queryset = Student.objects.all()
    serializer_class = StudentSerializer

    def get_queryset(self, *args, **kwargs):
        qs = super().get_queryset(*args, **kwargs)
        request = self.request
        user = request.user
        
        if not user.is_authenticated:
            return Student.objects.none()
        # elif user.user_type == 'school_based_supervisor':
        #     return qs.filter(school_based_supervisor = request.user.schoolsupervisor)
        elif user.user_type == 'industry_based_supervisor':
            return qs.filter(industry_based_supervisor = request.user.industrysupervisor)
        return None
    
class LogbookEntryView(ListAPIView):
    queryset = LogbookEntry.objects.all()
    serializer_class = StudentLogbookEntrySerializer

    def get_queryset(self, *args, **kwargs):
        qs = super().get_queryset(*args, **kwargs)
        request = self.request
        user = request.user
        
        if not user.is_authenticated:
            return LogbookEntry.objects.none()
        elif user.user_type == 'industry_based_supervisor':
            return LogbookEntry.objects.filter(student__industry_based_supervisor = request.user.industrysupervisor)
        elif user.user_type == 'school_based_supervisor':
            return LogbookEntry.objects.filter(student__school_based_supervisor = request.user.schoolsupervisor)
        
        return None
        # return qs.filter(student__industry_based_supervisor = request.user.industrysupervisor)
    
class PlacementCentreView(ListCreateAPIView):
    queryset = PlacementCentre.objects.all()
    serializer_class = PlacementCentreSerializer

    def get_queryset(self):
        qs = super().get_queryset()
        request = self.request
        user = request.user
        if not user.is_authenticated:
            return PlacementCentre.objects.none()
        elif user.user_type == 'industry_based_supervisor':
            indRecord = IndustrySupervisor.objects.get(user = user)
            placement = indRecord.placement_center.id
            return PlacementCentre.objects.filter(id = placement)
        return qs
    
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
            # placement_serializer.save()
            # print(placement_serializer.data)

            return Response(placement_serializer.data, status=status.HTTP_201_CREATED) 
        else:
            return Response(placement_serializer.errors, status = status.HTTP_400_BAD_REQUEST)
