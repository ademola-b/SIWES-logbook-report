import base64
from django.core.files.storage import default_storage
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
            'id',
            'student',
            'week',
            'industry_comment',
            'school_comment'
        ]

    def create(self, validated_data):
        data, _ = WeekComment.objects.get_or_create(student = validated_data['student'], week = validated_data['week'])
        # print(data)
        return data


class LogbookEntrySerializer(serializers.ModelSerializer):
    diagram_mem = serializers.SerializerMethodField("get_image_memory")
    # student = StudentSerializer()
    class Meta:
        model = LogbookEntry
        fields = [
            # 'student',
            'week',
            'entry_date', 
            'title',
            'description',
            'diagram',
            'diagram_mem'
        ]


    def get_image_memory(request, diagram:LogbookEntry):
        if diagram.diagram.name is not None:
            with default_storage.open(diagram.diagram.name, 'rb') as loadedfile:
                return base64.b64encode(loadedfile.read())

class GetLogbookEntrySerializer(serializers.ModelSerializer):
    diagram = serializers.SerializerMethodField("get_image_memory")
    # student = StudentSerializer()
    class Meta:
        model = LogbookEntry
        fields = [
            'week',
            'entry_date', 
            'title',
            'description',
            'diagram',
            # 'student'
        ]

    def get_image_memory(request, diagram:LogbookEntry):
        if diagram.diagram.name:
            with default_storage.open(diagram.diagram.name, 'rb') as loadedfile:
                return base64.b64encode(loadedfile.read())
