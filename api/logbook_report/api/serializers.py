from rest_framework import serializers

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
    class Meta:
        model = LogbookEntry
        fields = [
            'week',
            'entry_date', 
            'title',
            'description',
            'diagram',
        ]