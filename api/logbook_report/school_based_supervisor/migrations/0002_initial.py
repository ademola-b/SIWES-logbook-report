# Generated by Django 4.1.6 on 2023-03-13 09:46

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('students', '0001_initial'),
        ('school_based_supervisor', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='schoolsupervisor',
            name='department_id',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='students.department'),
        ),
        migrations.AddField(
            model_name='schoolsupervisor',
            name='user',
            field=models.OneToOneField(null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]
