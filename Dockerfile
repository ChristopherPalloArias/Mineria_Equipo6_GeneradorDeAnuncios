# Utiliza una imagen base de Python
FROM python:3.9-slim AS base

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de requerimientos y la aplicación en el contenedor
COPY requirements.txt ./
COPY app.py ./
COPY remove_background.py ./

# Descargar archivos desde una imagen en Docker Hub
FROM christopherpallo2000/grupo6anuncios:latest AS assets

# Copia los directorios necesarios desde la imagen descargada
COPY --from=assets /app/ad-gen ./ad-gen
COPY --from=assets /app/fonts ./fonts
COPY --from=assets /app/textures ./textures

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Expone el puerto que usará Streamlit
EXPOSE 8501

# Comando para ejecutar la aplicación cuando el contenedor se inicie
CMD ["streamlit", "run", "app.py"]
