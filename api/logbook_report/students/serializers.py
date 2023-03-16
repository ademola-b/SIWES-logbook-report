import base64
from rest_framework import serializers
from accounts.serializers import UserDetailSerializer
from industry_based_supervisor.serializers import IndustrySupervisorSerializer
from school_based_supervisor.serializers import SchoolSupervisorSerializer
from . models import Student

class StudentSerializer(serializers.ModelSerializer):
    user = UserDetailSerializer()
    department_id = serializers.StringRelatedField()
    school_based_supervisor = SchoolSupervisorSerializer()
    industry_based_supervisor = IndustrySupervisorSerializer()
    profile_pic_mem = serializers.SerializerMethodField("get_image_memory")
    class Meta:
        model = Student
        fields = [
        "id",
        "user",
        "profile_pic",
        "profile_pic_mem",
        "phone_no",
        "department_id",
        "school_based_supervisor",
        "industry_based_supervisor",
        "placement_location",
        ]

    def get_image_memory(request, student:Student):
        with open(student.profile_pic.name, 'rb') as loadedfile:
            return base64.b64encode(loadedfile.read())