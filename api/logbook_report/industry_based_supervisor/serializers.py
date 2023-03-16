import base64
from rest_framework import serializers
from accounts.serializers import UserDetailSerializer
from api.models import LogbookEntry

from students.models import Student

from . models import PlacementCentre
from . models import IndustrySupervisor, PlacementCentre


class PlacementCentreSerializer(serializers.ModelSerializer):
    class Meta:
        model = PlacementCentre
        fields = '__all__'

class IndustrySupervisorSerializer(serializers.ModelSerializer):
    user = UserDetailSerializer()
    profile_no_memory = serializers.SerializerMethodField("get_image_memory")
    placement_center = PlacementCentreSerializer()
    class Meta:
        model = IndustrySupervisor
        fields = [
            "id",
            "user",
            "profile_pic",
            "profile_no_memory",
            "phone_no",
            "placement_center"
        ]

    def get_image_memory(request, ind:IndustrySupervisor):
        with open(ind.profile_pic.name, 'rb') as loadedfile:
            return base64.b64encode(loadedfile.read())

class StudentListSerializer(serializers.ModelSerializer):
    user = UserDetailSerializer()
    pic_mem = serializers.SerializerMethodField("get_img_mem")
    class Meta:
        model = Student
        fields = [
            'id', 'user', 'pic_mem', 'phone_no'
        ]

    def get_img_mem(request, std:Student):
        with open(std.profile_pic.name, 'rb') as loadedfile:
            return base64.b64encode(loadedfile.read())

class StudentLogbookEntrySerializer(serializers.ModelSerializer):
    class Meta:
        model = LogbookEntry
        fields = '__all__'
