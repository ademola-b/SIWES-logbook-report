# from datetime import date, datetime, timedelta
import pandas
from itertools import zip_longest
from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.generics import ListCreateAPIView, ListAPIView, RetrieveUpdateAPIView
from rest_framework.response import Response

from . models import ProgramDate, WeekDates, LogbookEntry, WeekComment
from . serializers import ProgramDateSerializer, WeekDateSerializer, WeekCommentSerializer, LogbookEntrySerializer
# Create your views here.
def generate_date(start_date, end_date):
    dates = pandas.date_range(start_date, end_date).strftime('%Y-%m-%d').tolist()

    def grouper(iterable, n):
        args = [iter(iterable)] * n
        return zip_longest(*args)
    
    result = list(grouper(dates, 7)) #group dates in 7

    weeks = []
    for i in result:
        # weeks.append("WeekDates(start_date='{0}', end_date='{1}')".format(i[0], i[-2]))
        weeks.append(WeekDates(start_date=i[0], end_date=i[-2]))
    
    return weeks

class ProgramDateView(ListCreateAPIView):
    queryset = ProgramDate.objects.all()
    serializer_class = ProgramDateSerializer

    def post(self, request):
        program_data = request.data #to get the data before it's been posted
        program = ProgramDate.objects.create(start_date=program_data['start_date'], end_date=program_data['end_date'])
        days_gen = generate_date(program_data['start_date'], program_data['end_date'])
        week = WeekDates.objects.bulk_create(days_gen)
        data = {"start_date": program_data['start_date'], "end_date": program_data['end_date']}
        week_serializer = WeekDateSerializer(data=week)
        program_serializer = ProgramDateSerializer(data=data)
        # print(week_serializer)
        # if week_serializer.is_valid() and program_serializer.is_valid():
        if program_serializer.is_valid():
            # week_serializer.save()
            program_serializer.save()
            # dates_list = [week_serializer.data, program_serializer.data]
            print(program_serializer.data)
            return Response(program_serializer.data, status = status.HTTP_201_CREATED)
        else:
            return Response(program_serializer.errors, status = status.HTTP_400_BAD_REQUEST)

class WeekDatesView(ListAPIView):
    queryset = WeekDates.objects.all()
    serializer_class = WeekDateSerializer 
      

class WeekCommentView(ListCreateAPIView):
    queryset = WeekComment.objects.all()
    serializer_class = WeekCommentSerializer

    def get_queryset(self):
        qs = super().get_queryset()
        user = self.request.user
        try:
            if not user.is_authenticated:
                WeekComment.objects.none()
            elif user.is_staff:
                WeekComment.objects.all()
            
            return qs.filter(student = self.request.user.student)
        except:
            return None

class LogbookEntryView(ListCreateAPIView):
    queryset = LogbookEntry.objects.all()
    serializer_class = LogbookEntrySerializer

    def perform_create(self, serializer):
        serializer.save(student = self.request.user.student)
        return super().perform_create(serializer)

    def get_queryset(self):
        qs = super().get_queryset()
        request = self.request
        student = request.user
        try:
            if not student.is_authenticated:
                LogbookEntry.objects.none
            elif student.is_staff:
                LogbookEntry.objects.all()
            return qs.filter(student = self.request.user.student)
        except:
            return None
        
class LogbookWithDate(ListAPIView):
    serializer_class = LogbookEntrySerializer

    def get_queryset(self, *args, **kwargs):
        qs = LogbookEntry.objects.all()
        date = self.kwargs['date']
        # date = self.request.query_params.get(kwargs)
        # print(str(date))
        if date:
            qs = qs.filter(entry_date__date = date)
        elif date is None:
            return LogbookEntry.objects.none()
        return qs
    
class UpdateEntryWithComment(RetrieveUpdateAPIView):
    queryset = WeekComment
    serializer_class = WeekCommentSerializer


@api_view(['GET'])
def get_routes(request):
    routes = [
        {
            'Endpoint': 'api/',
            'method': 'GET',
            'body': None,
            'description': 'Returns list of routes'
        },
        {
            'Endpoint': 'api/accounts/login/',
            'method': 'POST',
            'body': 'Username/Email, Password',
            'description': 'Login and Returns the user token'
        },
        {
            'Endpoint': 'api/program_date/',
            'method': 'GET/POST',
            'body': 'start date, end date',
            'description': 'Returns the program date'
        },
        {
            'Endpoint': 'api/week_dates/',
            'method': 'GET',
            'body': None,
            'description': 'Returns range of dates between the program start and end date'
        },
        {
            'Endpoint': 'api/week_comment/',
            'method': 'GET',
            'body': None,
            'description': 'Returns list of weeks of the program'
        },
        {
            'Endpoint': 'api/logbook_entry/',
            'method': 'GET',
            'body': None,
            'description': ''
        },
        {
            'Endpoint': 'api/entry_date/<str:date>/',
            'method': 'GET',
            'body': None,
            'description': 'Returns entry date with a given date'
        },
        {
            'Endpoint': 'api/week_comment/<int:pk>/update/',
            'method': 'PUT',
            'body': 'student id, Week Id, Industry Supervisor Comment, School Supervisor Comment,',
            'description': 'Updates entry with comment'
        },

    ]
    return Response(routes)