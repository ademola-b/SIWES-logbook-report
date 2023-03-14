from django.contrib import admin

from . models import PlacementCentre
from . models import IndustrySupervisor, PlacementCentre
# Register your models here.
admin.site.register(IndustrySupervisor)
admin.site.register(PlacementCentre)