# Generated by Django 4.1.6 on 2023-02-15 13:57

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_siwesdate_alter_logbookentry_options_and_more'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='SiwesDate',
            new_name='ProgramDate',
        ),
    ]
