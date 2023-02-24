# Generated by Django 4.1.6 on 2023-02-16 07:04

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('industry_based_supervisor', '0003_remove_industrysupervisor_department_id_and_more'),
        ('school_based_supervisor', '0002_initial'),
        ('students', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='student',
            name='industry_based_supervisor',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='industry_based_supervisor.industrysupervisor', verbose_name='Industry Supervisor'),
        ),
        migrations.AlterField(
            model_name='student',
            name='placement_location',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='industry_based_supervisor.placementcentre', verbose_name='Placement Location'),
        ),
        migrations.AlterField(
            model_name='student',
            name='school_based_supervisor',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='school_based_supervisor.schoolsupervisor', verbose_name='School Supervisor'),
        ),
    ]
