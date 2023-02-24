from django.contrib.auth import get_user_model
from dj_rest_auth.serializers import UserDetailsSerializer
from rest_framework import serializers

class UserDetailSerializer(serializers.ModelSerializer):
  
    class Meta:
        model = get_user_model()
        fields = [
            "pk",
            "username", 
            "email",
            "first_name",
            "last_name",
        ]




