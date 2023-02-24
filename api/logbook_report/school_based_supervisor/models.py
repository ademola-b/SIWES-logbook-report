from django.contrib.auth import get_user_model
from django.db import models
from django.utils.translation import gettext as _


from students.models import profile_picture_dir
# Create your models here.
class SchoolSupervisor(models.Model):
    user = models.OneToOneField(get_user_model(), null=True, on_delete=models.CASCADE)
    profile_pic = models.ImageField(_("profile picture"), upload_to=profile_picture_dir)
    department_id = models.ForeignKey("students.Department", null=True, on_delete=models.SET_NULL)
    phone_no = models.CharField(max_length=11)

    def __str__(self):
        return self.user.username
    