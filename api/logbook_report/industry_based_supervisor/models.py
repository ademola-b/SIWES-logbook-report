from django.db import models
from django.contrib.auth import get_user_model
from django.db import models
from django.utils.translation import gettext as _

from students.models import profile_picture_dir

# Create your models here.
class PlacementCentre(models.Model):
    name = models.CharField(max_length = 50)
    longitude = models.CharField(max_length = 50)
    latitude = models.CharField(max_length = 50)
    radius = models.CharField(max_length = 3)

    def __str__(self):
        return self.name
    

class IndustrySupervisor(models.Model):
    user = models.OneToOneField(get_user_model(), null=True, on_delete=models.CASCADE)
    profile_pic = models.ImageField(_("profile picture"), upload_to=profile_picture_dir)
    phone_no = models.CharField(max_length=11)
    placement_center = models.ForeignKey("industry_based_supervisor.PlacementCentre", verbose_name=_("Placement Centre"), null=True, blank=True, on_delete=models.CASCADE)

    def __str__(self):
        return self.user.username