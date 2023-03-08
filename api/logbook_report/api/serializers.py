import base64
from rest_framework import serializers

from students.models import Student
from students.serializers import StudentSerializer
from . models import ProgramDate, WeekDates, LogbookEntry, WeekComment


class ProgramDateSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProgramDate
        fields = '__all__'

class WeekDateSerializer(serializers.ModelSerializer):
    class Meta:
        model = WeekDates
        fields = ['id','start_date', 'end_date']

class WeekCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = WeekComment
        fields = [
            'student',
            'week',
            'industry_comment',
            'school_comment'
        ]

class LogbookEntrySerializer(serializers.ModelSerializer):
    diagram = serializers.SerializerMethodField("get_image_memory")
    student = StudentSerializer()
    class Meta:
        model = LogbookEntry
        fields = [
            'week',
            'entry_date', 
            'title',
            'description',
            'diagram',
            'student'
        ]

    def get_image_memory(request, diagram:LogbookEntry):
        with open(diagram.diagram.name, 'rb') as loadedfile:
            return base64.b64encode(loadedfile.read())
