# -*- coding: utf-8 -*-
# Generated by Django 1.9.1 on 2016-01-15 19:47
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('webapp', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='dispositivo',
            name='alias',
        ),
        migrations.AlterField(
            model_name='dispositivo',
            name='id',
            field=models.AutoField(primary_key=True, serialize=False),
        ),
    ]