# Generated by Django 5.1.7 on 2025-03-28 06:07

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('asistencia', '0003_estudiante_grado_estudiante_nivel_estudiante_seccion'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='estudiante',
            name='codigo_barras',
        ),
    ]
