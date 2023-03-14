import json
from django.contrib.auth import get_user_model
from django.db import models

from django.utils.translation import gettext as _
# Create your models here.

def profile_picture_dir(instance, filename):
    return '{0}/{1}/{2}/{3}'.format('media', instance.user.user_type, instance.user.username, filename)


class Department(models.Model):
    deptName = models.CharField(max_length=50, unique=True)
    
    def __str__(self):
        return self.deptName

class Student(models.Model):
    user = models.OneToOneField(get_user_model(), null=True, on_delete=models.CASCADE)
    profile_pic = models.ImageField(_("profile picture"), upload_to=profile_picture_dir)
    department_id = models.ForeignKey(Department, null=True, on_delete=models.SET_NULL)
    phone_no = models.CharField(max_length=11)
    school_based_supervisor = models.ForeignKey("school_based_supervisor.SchoolSupervisor", verbose_name=_("School Supervisor"), null=True, on_delete=models.SET_NULL)
    industry_based_supervisor = models.ForeignKey("industry_based_supervisor.IndustrySupervisor", verbose_name=_("Industry Supervisor"), null=True, on_delete=models.SET_NULL)
    placement_location = models.ForeignKey("industry_based_supervisor.PlacementCentre", verbose_name=_("Placement Location"), null=True, blank=True, on_delete=models.SET_NULL)

    def __str__(self):
        # return json.dumps(dict(self))
        return self.user.username
    