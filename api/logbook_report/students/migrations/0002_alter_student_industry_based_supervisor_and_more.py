# Generated by Django 4.1.6 on 2023-03-18 19:55

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('industry_based_supervisor', '0002_alter_industrysupervisor_placement_center'),
        ('school_based_supervisor', '0002_initial'),
        ('students', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='student',
            name='industry_based_supervisor',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='industry_based_supervisor.industrysupervisor', verbose_name='Industry Supervisor'),
        ),
        migrations.AlterField(
            model_name='student',
            name='school_based_supervisor',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='school_based_supervisor.schoolsupervisor', verbose_name='School Supervisor'),
        ),
    ]
