import base64
from rest_framework import serializers
from accounts.serializers import UserDetailSerializer
from . models import SchoolSupervisor

from industry_based_supervisor.serializers import IndustrySupervisorSerializer
from students.models import Student

class SchoolSupervisorSerializer(serializers.ModelSerializer):
    user = UserDetailSerializer()
    department_id = serializers.StringRelatedField()
    profile_pic_memory = serializers.SerializerMethodField("get_image_memory")
    class Meta:
        model = SchoolSupervisor
        fields = [
            "id",
            "user",
            "profile_pic",
            "phone_no",
            "department_id",
            "profile_pic_memory"
            ]

    def get_image_memory(request, sch_supervisor:SchoolSupervisor):
        with open(sch_supervisor.profile_pic.name, 'rb') as loadedfile:
            return base64.b64encode(loadedfile.read())

class StudentListSerializer(serializers.ModelSerializer):
    user = UserDetailSerializer()
    pic_mem = serializers.SerializerMethodField("get_img_mem")
    industry_based_supervisor = IndustrySupervisorSerializer()
    class Meta:
        model = Student
        fields = [
            'id', 'user', 'pic_mem', 'phone_no', 'industry_based_supervisor'
        ]

    def get_img_mem(request, std:Student):
        with open(std.profile_pic.name, 'rb') as loadedfile:
            return base64.b64encode(loadedfile.read())
