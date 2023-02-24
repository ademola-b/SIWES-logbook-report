# Generated by Django 4.1.6 on 2023-02-15 06:41

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('industry_based_supervisor', '0001_initial'),
        ('students', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='industrysupervisor',
            name='department_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='students.department'),
        ),
        migrations.AddField(
            model_name='industrysupervisor',
            name='placement_center',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='industry_based_supervisor.placementcentre', verbose_name=''),
        ),
        migrations.AddField(
            model_name='industrysupervisor',
            name='user',
            field=models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]
