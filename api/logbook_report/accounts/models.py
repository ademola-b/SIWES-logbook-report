from django.db import models
from django.contrib.auth.models import User, AbstractUser
# Create your models here.

class CustomUser(AbstractUser):
    user_type_choice = [
        ('admin', 'admin'),
        ('student', 'student'),
        ('industry_based_supervisor', 'industry_based_supervisor'),
        ('school_based_supervisor', 'school_based_supervisor'),
    ]

    email = models.EmailField(unique=True)
    user_type = models.CharField(choices=user_type_choice, max_length=50, default='student')

from django.contrib.auth import get_user_model
from django.contrib.auth.backends import ModelBackend

class EmailBackend(ModelBackend):
    def authenticate(self, request, username=None, password=None, **kwargs):
        UserModel = get_user_model()
        try:
            user = UserModel.objects.get(username=username)
        except UserModel.DoesNotExist:
            try:
                user = UserModel.objects.get(email=username)
            except UserModel.DoesNotExist:
                # Run the default password hasher once to reduce the timing
                # difference between an existing and a nonexistent user (#20760).
                UserModel().set_password(password)
            else:
                if user.check_password(password) and self.user_can_authenticate(user):
                    return user
        else:
            if user.check_password(password) and self.user_can_authenticate(user):
                return user
