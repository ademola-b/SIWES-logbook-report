from django.db import models
from django.utils.translation import gettext as _

from students.models import profile_picture_dir

# Create your models here.
class ProgramDate(models.Model):
    start_date = models.DateField()
    end_date = models.DateField()
    
    class Meta:
        verbose_name_plural = "Program Date"

    def __str__(self):
        return '{0} - {1}'.format(self.start_date, self.end_date)
    

class WeekDates(models.Model):
    start_date = models.DateField(null=True, blank=True)
    end_date = models.DateField(null=True, blank=True)

    class Meta:
        verbose_name_plural = "Week Dates"

    def __str__(self):
        return '{0} - {1}'.format(self.start_date, self.end_date)

class WeekComment(models.Model):
    student = models.ForeignKey("students.Student", verbose_name=_("Student Id"), on_delete=models.CASCADE)
    week = models.ForeignKey("api.WeekDates", verbose_name=_("Week Id"), null=True, on_delete=models.CASCADE)
    industry_comment = models.CharField(_("Industry Supervisor Comment"), max_length=1000, null=True, blank=True)
    school_comment = models.CharField(_("School Supervisor Comment"), max_length=1000, null=True, blank=True)
    
    

class LogbookEntry(models.Model):
    week = models.ForeignKey("api.WeekDates", verbose_name=_("Week Id"), null=True, on_delete=models.SET_NULL)
    student = models.ForeignKey("students.Student", verbose_name=_("Student Id"), on_delete=models.CASCADE)
    entry_date = models.DateTimeField()
    title = models.CharField(_("Title"), max_length=50)
    description = models.CharField(_("Description"), max_length=1000)
    diagram = models.ImageField(_("Diagram"), upload_to=profile_picture_dir)

    class Meta:
        verbose_name_plural = "Logbook Entries"

    def __str__(self):
        return '{0} - {1}'.format(self.entry_date, self.student.user.username)
    