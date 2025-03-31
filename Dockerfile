# Dockerfile para proyecto Django con Gunicorn
# Utiliza imagen base Python 3.10 slim (optimizada para tamaño)
FROM python:3.10-slim

# Configuración de entorno para Python
ENV PYTHONUNBUFFERED=1

# Establece directorio de trabajo
WORKDIR /app

# Instalación de dependencias del sistema (opcional, para paquetes que requieran compilación)
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copia e instalación de dependencias Python
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copia todo el proyecto al contenedor
COPY . .

# Recolección de archivos estáticos (requiere STATIC_ROOT configurado en settings.py)
RUN mkdir -p /app/staticfiles && \
    mkdir -p /app/asistencia/static && \
    chmod -R 755 /app/staticfiles
RUN python manage.py collectstatic --no-input

# Aplicación de migraciones (opcional, puede ejecutarse manualmente después)
# RUN python manage.py migrate --no-input

# Expone el puerto de la aplicación
EXPOSE 8000

# Comando de inicio con Gunicorn
CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]