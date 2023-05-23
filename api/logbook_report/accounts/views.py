from django.contrib.auth import get_user_model
from django.shortcuts import render

from rest_framework.generics import ListAPIView

from . serializers import UserDetailSerializer

# Create your views here.
class UserDetail(ListAPIView):
    queryset = get_user_model().objects.all()
    serializer_class = UserDetailSerializer

    def get_queryset(self, *args, **kwargs):
        qs = super().get_queryset()
        request = self.request
        user = request.user

        return qs.filter(id = request.user.id)
    
    
