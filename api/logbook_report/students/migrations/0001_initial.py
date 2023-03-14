# Generated by Django 4.1.6 on 2023-03-13 09:46

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import students.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('industry_based_supervisor', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('school_based_supervisor', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Department',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('deptName', models.CharField(max_length=50, unique=True)),
            ],
        ),
        migrations.CreateModel(
            name='Student',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('profile_pic', models.ImageField(upload_to=students.models.profile_picture_dir, verbose_name='profile picture')),
                ('phone_no', models.CharField(max_length=11)),
                ('department_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='students.department')),
                ('industry_based_supervisor', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='industry_based_supervisor.industrysupervisor', verbose_name='Industry Supervisor')),
                ('placement_location', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='industry_based_supervisor.placementcentre', verbose_name='Placement Location')),
                ('school_based_supervisor', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='school_based_supervisor.schoolsupervisor', verbose_name='School Supervisor')),
                ('user', models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
