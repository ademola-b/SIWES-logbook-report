import base64
from rest_framework import serializers
from accounts.serializers import UserDetailSerializer
from . models import SchoolSupervisor

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